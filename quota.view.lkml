include: "//app-sales/quota_core.view.lkml"

############################################################################################################################
### TODO: Set up the Quotas view.  There are several ways to set up the quota view. The important thing is that Looker   ###
###       can find a view called quota that has a row for every Sales Rep with a name for joining, ae_segment            ###
###       for grouping, a yearly quota_number for each user and the aggregate quota dimension (can be filled in at       ###
###       the dimension level).                                                                                          ###
############################################################################################################################

############################################################################################################################
### Below is one potential way to structure the quota table. Quota map is a mapping between usernames and ae_segments    ###
### and quota_numbers is a mapping between ae_segments to quota_amounts. The quota view joins these two tables to create ###
### the quota table that is ultimately joined into the model.                                                            ###
############################################################################################################################

view: quota_map {
  derived_table: {
    sql:
      SELECT 'Zacherie Clausen' as name, 'Inside Sales 1' as ae_segment
      UNION ALL
      SELECT 'Tiffani Helstrom' as name, 'Inside Sales 2' as ae_segment
      UNION ALL
      SELECT 'Gwendolyn Maris' as name, 'Outside Sales 1' as ae_segment
      UNION ALL
      SELECT 'Reine Duckerin' as name, 'Outside Sales 2' as ae_segment
    ;;
  }
}

view: quota_numbers {
  derived_table: {
    sql:
      SELECT 'Inside Sales' as ae_seg, 200000 as quota_amount
      UNION ALL
      SELECT 'Outside Sales' as ae_seg, 500000 as quota_amount
    ;;
  }
}


view: quota {
  extends: [quota_core]
  derived_table: {
    sql:
      SELECT *
      FROM ${quota_map.SQL_TABLE_NAME}
      LEFT JOIN ${quota_numbers.SQL_TABLE_NAME} ON quota_map.ae_segment = quota_numbers.ae_seg
    ;;
  }



  ##########################################################################################################
  ### TODO: Aggregate Quotas are defined with a hardcoded value and are independent of the quotas table. ###
  ##########################################################################################################

  # TODO: The aggregate quota for the entire org should be defined here. This should be a yearly number.
  dimension: aggregate_quota {
    type: number
    sql: 1000000 ;;
    hidden: yes
    value_format_name: custom_amount_value_format
  }

  # TODO: Set hardcoded quarterly quotas for managers with this field.
  dimension: manager_quota {
    type: number
    sql:
    CASE WHEN ${manager.name} = 'Manager 1' THEN 100000
         WHEN ${manager.name} = 'Manager 2' THEN 200000
         WHEN ${manager.name} = 'Manager 3' THEN 300000
         ELSE NULL
         END
    ;;
    value_format_name: custom_amount_value_format
  }

  ## Customize - This field corrects for users that were created as SFDC users before they were Sales Reps.
  ## This is used for comparing the reps first 18 months against each other.
  ## This number should be set as the number of months they were in their previous role.
  ## e.g. Billy Kane was an SDR for 13 months before they were a Sales Rep.
#  dimension: quota_effective_date_offset {
#    type:  number
#    sql: CASE WHEN ${name} = 'Billy Kane' THEN 13
#              WHEN ${name} = 'Jetty Attorn' THEN 14
#              WHEN ${name} = 'Alile Clarey' THEN 14
#              WHEN ${name} = 'Brianna Berenstein' THEN 20
#              WHEN ${name} = 'Haily Fields' THEN 12
#              WHEN ${name} = 'Elon McCalhy' THEN 10
#              WHEN ${name} = 'TJ Robinho' THEN 5
#              WHEN ${name} = 'Oliver Summer' THEN 9
#              ELSE 0
#              END
#                ;;
#    hidden: yes
#  }

  ## Customize - this field groups similar ae_segments together for  the purpose of comparison.
  ## e.g. if a company had ae_segments like Inside 1 and Inside 2 with different quotas, we can group them together with this field.
  ## Can be ignored if ae_segment doesn't need to be grouped.
#  dimension: segment_grouping {
#    type: string
#    sql: CASE WHEN ${ae_segment} ILIKE 'Inside%' THEN 'Inside Sales'
#              WHEN ${ae_segment} ILIKE 'Outside%' THEN 'Outside Sales'
#              ;;
#    hidden: yes
#  }

}

############################################################################################################################
### TODO: Set up the Aggregate Quota view. This view will contain historical aggregate goals for your entire             ###
### organization. Structurally, this view should be defined similarly to the standard Quota view (i.e. multiple SELECT   ###
### statements, each corresponding to the current or a previous quarter).                                                ###
############################################################################################################################

view: aggregate_quota {
  extends: [aggregate_quota_core]
  derived_table: {
    sql:
    SELECT '2018-01-01' as quota_start_date, 10211100 as aggregate_quota
    UNION ALL
    SELECT '2018-04-01' as quota_start_date, 11948700 as aggregate_quota
    UNION ALL
    SELECT '2018-07-01' as quota_start_date, 13233800 as aggregate_quota
    UNION ALL
    SELECT '2018-10-01' as quota_start_date, 14251400 as aggregate_quota
    UNION ALL
    SELECT '2019-01-01' as quota_start_date, 16800000 as aggregate_quota
    UNION ALL
    SELECT '2019-04-01' as quota_start_date, 18000000 as aggregate_quota;;
  }

  dimension: aggregate_quota {
    sql: ${TABLE}.aggregate_quota ;;
  }
}
