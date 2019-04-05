include: "//app-sales/lead_core.view.lkml"
include: "//app-sales-adapter/lead_adapter.view.lkml"

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

  # Customize: This field is a filter for leads that would be considered ‘Active’.
  #       This can be a filter on their duration as leads or any arbitrary factors. Default is 1=1 (no filter)
#   dimension: is_active_lead {
#     type: yesno
#     sql: ${status} NOT IN ('Unsubscribed','Disqualified') ;;
#   }
}
