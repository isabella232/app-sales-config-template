include: "//app-sales/opportunity_history_core.view.lkml"

# Customize: Change the schema or table name.
view: opportunity_history_schema {
  sql_table_name: salesforce.opportunity_history ;;
  extension: required
}

# Customize: Override dimensions or measures here
view: opportunity_history {
  extends: [opportunity_history_core]
}
