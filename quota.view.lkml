include: "//app-sales/quota_core.view.lkml"


############################################################################################################################
### TODO: Set up the Quotas view.  There are many ways to set up the quota view. The important thing is that Looker      ###
###       can find a view called quota that has a row for every Sales Rep for each quarter, going back 4 quarters.       ###
###       The columns needed will be a name for joining, ae_segment for grouping, a quota_amount for each user/qtr       ###
###       and quota_start_date which will be the first date the quota is for, in YYYY-MM-DD form                         ###
############################################################################################################################



view: quota {
  extends: [quota_core]
  derived_table: {
    sql:
    SELECT 'Zacherie Clausen' as name, 'Inside AE' as ae_segment, 10000 as quota_amount, '2018-04-01' as quota_start_date
    UNION ALL
    SELECT 'Zacherie Clausen' as name, 'Inside AE' as ae_segment, 12000 as quota_amount, '2018-07-01' as quota_start_date
    UNION ALL
    SELECT 'Zacherie Clausen' as name, 'Inside AE' as ae_segment, 10000 as quota_amount, '2018-10-01' as quota_start_date
    UNION ALL
    SELECT 'Zacherie Clausen' as name, 'Inside AE' as ae_segment, 12000 as quota_amount, '2019-01-01' as quota_start_date
    UNION ALL
    SELECT 'Tiffani Helstrom' as name, 'Enterprise AE' as ae_segment, 20000 as quota_amount, '2019-01-01' as quota_start_date
    UNION ALL
    SELECT 'Tiffani Helstrom' as name, 'Enterprise AE' as ae_segment, 32000 as quota_amount, '2019-04-01' as quota_start_date
    UNION ALL
    SELECT 'Tiffani Helstrom' as name, 'Enterprise AE' as ae_segment, 20000 as quota_amount, '2019-01-01' as quota_start_date
    UNION ALL
    SELECT 'Tiffani Helstrom' as name, 'Enterprise AE' as ae_segment, 32000 as quota_amount, '2019-01-01' as quota_start_date
    ;;
  }



  # Customize: By default manager_quota is populated from the manager_quota derived table.
  # The manager_quota derived table aggregates the individual quota values declared in the app-sales-config/quota table.
  # If a manager's quota is not the sum of that manager's rep's quotas, then this case when statement can be used to
  # hardcode manager's quotas.
  dimension: manager_quota {
    type: number
    sql: ${manager_quota.total_quota} ;;
#     sql:
#     CASE WHEN ${manager.name} = 'Manager 1' THEN 100000
#          WHEN ${manager.name} = 'Manager 2' THEN 200000
#          WHEN ${manager.name} = 'Manager 3' THEN 300000
#          ELSE NULL
#          END
#     ;;
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

view: manager_quota {
  extends: [manager_quota_core]
}
