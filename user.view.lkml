include: "//app-sales/user_core.view.lkml"
include: "//app-sales-adapter/user_adapter.view.lkml"

# Customize: Change the schema or table name.
view: user_schema {
  sql_table_name: salesforce.user ;;
  extension: required
}

# Customize: Override dimensions or measures here
view: user {
  extends: [user_core]

# TODO: Identify which Users are Sales reps using this dimension.
#     i.e.  ${department} = 'Sales' AND ${title} IN ('Outside AE', 'AE', 'Inside AE', 'Account Executive', 'MM AE', 'Commercial AE');;
  dimension: is_sales_rep {
    type: yesno
    sql: 1=1 ;;
  }

  # Customize - How longh does it take an AE to ramp
  # Used in Comparison Views, this will filter ramping AE's from rankings.
  # e.g. ${months_age} > 3 ;;
  dimension: is_ramped {
    type: yesno
    sql: 1=1 ;;
  }

  # TODO: Set your Salesforce domain (i.e. https:// _____________ .com )
  dimension: salesforce_domain_config {
    sql: looker.my.salesforce.com;;
  }

  # TODO: This field will be used to divide your users/sales reps up by region
  dimension: ae_region {
    type: string
    sql: 'Configure AE Region' ;;
  }
}
