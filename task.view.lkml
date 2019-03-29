include: "//app-sales/task_core.view.lkml"
include: "//app-sales-adapter/task_adapter.view.lkml"

# Customize: Change the schema or table name.
view: task_schema {
  sql_table_name: salesforce.task ;;
  extension: required
}

# Customize: Override dimensions or measures here
view: task {
  extends: [task_core]

  # TODO: Set your Salesforce domain (i.e. https:// _____________ .com )
  dimension: salesforce_domain_config {
    sql: looker.my.salesforce.com;;
  }

  # TODO: Define which task types are equivalent to a meeting with prospects
  dimension: is_this_task_a_meeting {
    type: yesno
    sql: ${type} = 'Call' OR ${type} LIKE '%Meeting%' ;;
  }
}