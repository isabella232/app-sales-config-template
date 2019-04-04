include: "//app-sales/task_core.view.lkml"
include: "//app-sales-adapter/task_adapter.view.lkml"

# TODO: Change the schema or table name.
view: task_schema {
  sql_table_name: salesforce.task ;;
  extension: required
}

# Customize: Override dimensions or measures here
view: task {
  extends: [task_core]

  # Customize: Set your Salesforce domain (i.e. https:// _____________ .com )
  dimension: salesforce_domain_config {
    sql: looker.my.salesforce.com;;
  }

  # TODO: Define which tasks represent a meeting with prospects
  dimension: is_meeting {
    type: yesno
    sql: ${type} LIKE '%Meeting%' ;;
  }
}
