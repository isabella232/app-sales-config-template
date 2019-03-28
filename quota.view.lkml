include: "//app-sales/quota_core.view.lkml"
view: quota_map {
  derived_table: {
    sql:
    SELECT 'Zacherie Clausen' as name, 'Inside Sales' as ae_segment
    UNION ALL
    SELECT 'Tiffani Helstrom' as name, 'Inside Sales' as ae_segment
    UNION ALL
    SELECT 'Gwendolyn Maris' as name, 'Outside Sales' as ae_segment
    UNION ALL
    SELECT 'Reine Duckerin' as name, 'Outside Sales' as ae_segment
      ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    hidden: yes
    primary_key: yes
  }

  dimension: ae_segment {
    type: string
    sql: ${TABLE}.ae_segment ;;
  }


  dimension: quota_effective_date_offset {
    type:  number
    sql: CASE WHEN ${name} = 'Billy Kane' THEN 13
              WHEN ${name} = 'Jetty Attorn' THEN 14
              WHEN ${name} = 'Alile Clarey' THEN 14
              WHEN ${name} = 'Brianna Berenstein' THEN 20
              WHEN ${name} = 'Haily Fields' THEN 12
              WHEN ${name} = 'Elon McCalhy' THEN 10
              WHEN ${name} = 'TJ Robins' THEN 5
              WHEN ${name} = 'Oliver Summer' THEN 9
              ELSE 0
              END
                ;;
    hidden: yes
  }

  filter: segment_select {
    suggest_dimension: ae_segment
  }

  dimension: segment_grouping {
    type: string
    sql: CASE WHEN ${ae_segment} ILIKE 'Commercial%' THEN 'Commercial'
              WHEN ${ae_segment} ILIKE 'Named%' THEN 'Named Accounts'
              WHEN ${ae_segment} ILIKE 'Mid%' THEN 'Mid-Market'
              WHEN ${ae_segment} ILIKE 'Inside%' THEN 'Inside'
              WHEN ${ae_segment} ILIKE 'Enterprise%' THEN 'Enterprise'
              END
              ;;
  }

}

view: quota_numbers {
  derived_table: {
    sql:
      SELECT 'Inside Sales' as ae_seg, 200000 as quota_amount, '2018-04-01' as start_date
      UNION ALL
      SELECT 'Outside Sales' as ae_seg, 500000 as quota_amount, '2018-04-01' as start_date
    ;;

    }

  dimension: ae_segment {
    primary_key:yes
    hidden:yes
  }

  dimension: quota_quantity {
    hidden: yes
    label: "Services Quota"
  }

  dimension: start_date {
    hidden: yes
  }

  dimension: quota_amount {
    label: "Yearly Quota"
    hidden: yes
    type: number
    value_format_name: custom_amount_value_format
  }

  dimension: quarterly_quota {
    label: "Quota"
    type: number
    hidden: yes
    sql: ${quota_amount}/4 ;;
    description: "Quarterly Quota"
    value_format_name: custom_amount_value_format
  }

### What is the overall yearly quota
  dimension: aggregate_quota {
    type: number
    hidden: yes
    sql: 67200000 ;;
    value_format_name: custom_amount_value_format
  }

### Might need agg_quota as a measure or viz purposes
    measure: aggregate_quota_measure {
      label: "Aggregate Quota"
      group_label: "Quota"
      type: max
      sql: ${aggregate_quota} ;;
      value_format_name: custom_amount_value_format
    }

    measure: monthly_aggregate_quota_measure {
      type: number
      label: "Monthly Quota"
      group_label: "Quota"
      sql: ${aggregate_quota}/12 ;;
      value_format_name: custom_amount_value_format
    }

    measure: quarterly_aggregate_quota_measure {
      type: number
      label: "Quarterly Quota"
      group_label: "Quota"
      sql: ${aggregate_quota}/4 ;;
      value_format_name: custom_amount_value_format
    }


    measure: total_quota {
      type: sum_distinct
      group_label: "Quota"
      sql:${quota_amount} ;;
      value_format_name: custom_amount_value_format
    }

    measure: SDR_quota {
      type: sum
      sql:${quota_amount} ;;
      filters: {
        field: opportunity.source
        value: "SDR"
      }
      value_format_name: custom_amount_value_format
    }


  }

  view: quota_aggregation {
    derived_table: {
      sql:
          SELECT quota_map.ae_segment, sum(quota_amount) as segment_quota
          FROM ${quota.SQL_TABLE_NAME}
          GROUP BY 1
          ;;
    }

    dimension: ae_segment {hidden: yes}
    dimension: segment_quota {
      type:number
      value_format_name: custom_amount_value_format
      hidden: yes
    }


  }

view: quota {
  extends: [quota_core]
  derived_table: {
    sql:  SELECT *
          FROM ${quota_map.SQL_TABLE_NAME}
          LEFT JOIN ${quota_numbers.SQL_TABLE_NAME} ON quota_map.ae_segment = quota_numbers.ae_seg ;;
  }

  filter: segment_select {
    suggest_dimension: ae_segment
    hidden: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    primary_key: yes
    hidden: yes
  }

  dimension: ae_segment {
    type: string
    sql: ${TABLE}.ae_segment ;;
    view_label: "Opportunity Owner"
  }

  dimension: quota_effective_date_offset {
    type:  number
    sql: CASE WHEN ${name} = 'Billy Kane' THEN 13
              WHEN ${name} = 'Jetty Attorn' THEN 14
              WHEN ${name} = 'Alile Clarey' THEN 14
              WHEN ${name} = 'Brianna Berenstein' THEN 20
              WHEN ${name} = 'Haily Fields' THEN 12
              WHEN ${name} = 'Elon McCalhy' THEN 10
              WHEN ${name} = 'TJ Robins' THEN 5
              WHEN ${name} = 'Oliver Summer' THEN 9
              ELSE 0
              END
                ;;
    hidden: yes
  }


  dimension: segment_grouping {
    type: string
    sql: CASE WHEN ${ae_segment} LIKE 'Commercial%' THEN 'Commercial'
              WHEN ${ae_segment} LIKE 'Named%' THEN 'Named Accounts'
              WHEN ${ae_segment} LIKE 'Mid%' THEN 'Mid-Market'
              WHEN ${ae_segment} LIKE 'Inside%' THEN 'Inside'
              WHEN ${ae_segment} LIKE 'Enterprise%' THEN 'Enterprise'
              END
              ;;
    hidden: yes
  }

  dimension: quota_quantity {
    label: "Services Quota"
    hidden: yes
  }

  dimension: start_date {
    hidden: yes
  }

  dimension: quota_amount {
    label: "Yearly Quota"
    type: number
    hidden: no
    value_format_name: custom_amount_value_format
  }

  dimension: quarterly_quota {
    label: "Quota"
    type: number
    hidden: no
    sql: ${quota_amount}/4 ;;
    description: "Quarterly Quota"
    value_format_name: custom_amount_value_format
  }

### What is the overall yearly quota
  dimension: aggregate_quota {
    type: number
    sql: 1000000 ;;
    hidden: yes
    value_format_name: custom_amount_value_format
  }

### Might need agg_quota as a measure or viz purposes
  measure: aggregate_quota_measure {
    type: max
    label: "Aggregate Quota"
    group_label: "Quota"
    view_label: "Opportunity Owner"
    sql: ${aggregate_quota} ;;
    value_format_name: custom_amount_value_format
  }

  measure: monthly_aggregate_quota_measure {
    type: number
    label: "Monthly Quota"
    group_label: "Quota"
    view_label: "Opportunity Owner"
    sql: ${aggregate_quota}/12 ;;
    value_format_name: custom_amount_value_format
  }

  measure: quarterly_aggregate_quota_measure {
    type: number
    label: "Quarterly Quota"
    group_label: "Quota"
    view_label: "Opportunity Owner"
    sql: ${aggregate_quota}/4 ;;
    value_format_name: custom_amount_value_format
  }


  measure: total_quota {
    type: sum_distinct
    label: "Total Quota"
    group_label: "Quota"
    view_label: "Opportunity Owner"
    sql:${quota_amount} ;;
    value_format_name: custom_amount_value_format
  }


}

