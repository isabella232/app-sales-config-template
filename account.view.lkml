include: "//app-sales/account_core.view.lkml"
include: "//app-sales-adapter/account_adapter.view.lkml"

# TODO: Change the schema or table name.
view: account_schema {
  sql_table_name: salesforce.account ;;
  extension: required
}

# TODO: Override dimensions or measures here
view: account {
  extends: [account_core]

  # TODO: Set your Salesforce domain (i.e. https:// _____________ .com )
  dimension: salesforce_domain_config {
    sql: looker.my.salesforce.com;;
    hidden: yes
  }
  
  # TODO: Define your business segments below. Note you can use a custom field as a part of this dimension's definition
  dimension: business_segment {
    type: string
    case: {
      when: {
        sql: ${number_of_employees} IN ('Under 50', '51 - 200', '201 - 500') ;;
        label: "Small Business"
      }
      when: {
        sql: ${number_of_employees} IN ('501 - 1000') ;;
        label: "Mid-Market"
      }
      when: {
        sql: ${number_of_employees} IN ('1001 - 3000', '3001 - 5000', '5001 - 10000', '10001+') ;;
        label: "Enterprise"
      }
      else: "Unknown"
    }
  }
 }
