include: "//app-sales/opportunity_core.view.lkml"
include: "//app-sales-adapter/opportunity_adapter.view.lkml"

# TODO: Change the schema or table name.
view: opportunity_schema {
  sql_table_name: salesforce.opportunity ;;
  extension: required
}

##########################################
## Override dimensions or measures here ##
##########################################
view: opportunity {
 extends: [opportunity_core, stage_customization]

  # TODO: Set your Salesforce domain (i.e. https:// _____________ .com )
    dimension: salesforce_domain_config {
    sql: looker.my.salesforce.com;;
    hidden: yes
    }

  #TODO: This should refer to the database column that salespeople are measured against. This can be ACV, Amount, revenue etc
    dimension: amount_config {
    sql: amount ;;
    }

  #TODO: Amount name will be how the measures built with amount_config will appear in the label of the field. The display name.
    dimension: amount_display {
    sql:  Amount ;;
    hidden: yes
    }

  #TODO: is_pipeline will determine in which stages an opportunity is considered pipeline
    dimension: is_pipeline {
    type: yesno
    sql: ${forecast_category} in ('Pipeline','Upside','BestCase') AND ${stage_name} <> 'Closed Lost' ;;
    group_label: "Status"
    }

  #TODO: is_included_in_quota will determine which opportunites count towards quota calculations.
    dimension: is_included_in_quota {
    type: yesno
    sql: ${type} IN ('New Business','New Customer','Marketplace','Amendment','Resell','Addon/Upsell') ;;
    group_label: "Status"
    }

  #TODO: is_new_business will determine which opportunities are new business opps
    dimension: is_new_business {
    type: yesno
    sql: ${type} IN ('New Business','New Customer','Marketplace', 'Resell') ;;
    group_label: "Status"
    }

  #TODO: is_renewal_upsell will determine which opportunities are renewals and upsells
    dimension: is_renewal_upsell {
    type: yesno
    sql: ${type} IN ('Existing Business','Renewal','Addon/Upsell') ;;
    group_label: "Status"
  }

  # TODO: Define what it means for an opportunity to require follow up action
  #       (This example is a filter for opps in stage 1 that have a meeting date in the past)
  dimension: requires_action {
    type: yesno
    sql: ${first_meeting_raw} < CURRENT_TIMESTAMP() AND ${stage_name} = 'Validate' ;;
    group_label: "Status"
  }

    # TODO - Optional: This field tiers the sizes of your deal. This is the default, uncomment and adjust for configuration.
#   dimension: deal_size_tier {
#     type: string
#     case: {
#       when: {
#         label: "$0 - $10K"
#         sql: ${amount} < 10000 ;;
#       }
#       when: {
#         label: "$10K - $50K"
#         sql: ${amount} < 50000;;
#       }
#       when: {
#         label: "$50K - $100K"
#         sql: ${amount} < 100000 ;;
#       }
#       when: {
#         label: "$100K - $500K"
#         sql: ${amount} < 500000 ;;
#       }
#       when: {
#         label: "$500K - $1M"
#         sql: ${amount} < 1000000 ;;
#       }
#       when: {
#         label: "Over $1M"
#         sql: ${amount} > 1000000 ;;
#       }
#       else: "Amount Unspecified"
#     }
#   }
   }
# TODO: Define your stage names below (make sure that no spaces lie between the last char of your stage names and the double semi-colon in the sql parameters)
view: stage_customization {

  dimension: stage_1 {
    type: string
    sql: Validate;;
  }

  dimension: stage_2 {
    type: string
    sql: Qualify;;
  }

  dimension: stage_3 {
    type: string
    sql: Develop;;
  }

  dimension: stage_4 {
    type: string
    sql: Develop Positive;;
  }

  dimension: stage_5 {
    type: string
    sql: Negotiate;;
  }

  dimension: stage_6 {
    type: string
    sql: Sales Submitted;;
  }

  dimension: stage_7 {
    type: string
    sql: Closed Won;;
  }
}
