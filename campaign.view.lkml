include: "//app-sales/campaign_core.view.lkml"

# Customize: Change the schema or table name.
view: campaign_schema {
  sql_table_name: salesforce.campaign ;;
  extension: required
}

# Customize: Override dimensions or measures here
view: campaign {
  extends: [campaign_core]
}
