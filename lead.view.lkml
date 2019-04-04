include: "//app-sales/lead_core.view.lkml"

# Customize: Change the schema or table name.
view: lead_schema {
  sql_table_name: salesforce.lead ;;
  extension: required

}

# Customize: Override dimensions or measures here
view: lead {
  extends: [lead_core]

  # Customize: Set your Salesforce domain (i.e. https:// _____________ .com )
  dimension: salesforce_domain_config {
    sql: looker.my.salesforce.com;;
  }
  dimension: is_active_lead {
    type: yesno
    sql: 1=1  ;;
  }
}
