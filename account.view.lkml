include: "//app-sales/account_core.view.lkml"
include: "//app-sales-adapter/account_adapter.view.lkml"
include: "//app-sales/account_facts.view.lkml"

# Customize: Change the schema or table name.
view: account_schema {
  sql_table_name: salesforce.account ;;
  extension: required
}

# Customize: Override dimensions or measures here
view: account {
  extends: [account_core]

  # Customize: Set your Salesforce domain (i.e. https:// _____________ .com )
  dimension: salesforce_domain_config {
    sql: looker.my.salesforce.com;;
    hidden: yes
  }

  # Customize: Set the logic that will mark an account as either a customer account or a non-customer account
  dimension: is_customer {
    sql: 1=1 ;;
  }

  # Customize: Define your business segments at the account level here. This can be grouped based on things like company size
  # or any other segmentation you'd want to break down accounts by.
  dimension: business_segment {
    type: string
    case: {
      when: {
        sql: ${number_of_employees} <= 500 ;;
        label: "Small Business"
      }
      when: {
        sql: ${number_of_employees} >= 10000 ;;
        label: "Enterprise"
      }
      when: {
        sql: ${number_of_employees} >500 AND ${number_of_employees} <10000  ;;
        label: "Mid-Market"
      }
      else: "Unknown"
    }
  }
 }
 
 view: account_facts_is_customer {
  extends: [account_facts_is_customer_core]
}
