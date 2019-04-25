connection: "app-salesforce"

include: "*.view"
include: "//app-sales-adapter/*.view"
include: "//app-sales/*.view"
include: "//app-sales/*.explore"
include: "//app-sales/*.dashboard"


  # datagroup for caching policy and persistent derived tables (PDTs) #
  # check if any of the Salesforce tables surfaced in Looker have been updated and synced recently
datagroup: sales_analytics_etl {
  sql_trigger:
    SELECT MAX(done) FROM `salesforce.fivetran_audit`
    WHERE schema = 'salesforce' AND table in ('account', 'campaign', 'contact', 'lead', 'opportunity', 'user') ;;
  max_cache_age: "1 hour"
}


## CUSTOMIZE - Set fiscal month offset to how many months after January to start the fiscal year.
## NOTE - This parameter must match the sql: parameter of the opportunity.fiscal_month_offset dimension
# fiscal_month_offset: 0

named_value_format: custom_amount_value_format {
  value_format: "[>=1000000]$0.0,,\"M\";[>=1000]$0,\"K\";$0.00"
}



#########################
#### Explore Extends ####
#########################

### Customize: This Section is where you can add joins to custom views, or to exclude fields from Explores.
### This is useful for adding joins to additional custom derived tables and customizing which fields appear in the Explores.
### There are a few examples here: https://github.com/looker/app-sales-config-templates/blob/master/sales_analytics_explore_extends

explore: opportunity {
  extends: [opportunity_core]
  fields: [EXTENDED*]
}

explore: account {
  extends: [account_core]
  fields: [EXTENDED*]
}

explore: opportunity_history_waterfall {
  extends: [opportunity_history_waterfall_core]
  fields: [EXTENDED*]
}

explore: lead {
  extends: [lead_core]
  fields: [EXTENDED*]
}

explore: contact {
  extends: [contact_core]
  fields: [EXTENDED*]
}
