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
 extends: [opportunity_core]
 
  # TODO: Set your Salesforce domain (i.e. https:// _____________ .com )
    dimension: salesforce_domain_config {
    sql: looker.my.salesforce.com;;
    hidden: yes
    }
  
  #TODO: This should refer to the database column that salespeople are measured against. This can be ACV, Amount, revenue etc
    dimension: amount_config {
    sql: acv_2_0_c ;;
    }

  #TODO: Amount name will be how the measures built with amount_config will appear in the label of the field. The display name.
    dimension: amount_display {
    sql:  ACV ;;
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
  
  #TODO: custom stage name field will determine what order your stages should be in.
  dimension: custom_stage_name {
    label: "Stage Name"
    case: {
      when: {
        sql: ${stage_name} = 'Stage 1' ;;
        label: "Stage 1"
      }
      when: {
        sql: ${stage_name} = 'Stage 2' ;;
        label: "Stage 2"
      }
      when: {
        sql: ${stage_name} = 'Stage 3' ;;
        label: "Stage 3"
      }
      when: {
        sql: ${stage_name} = 'Stage 4' ;;
        label: "Stage 4"
      }
      when: {
        sql: ${stage_name} = 'Stage 5' ;;
        label: "Stage 5"
      }
      when: {
        sql: ${stage_name} = 'Stage 6' ;;
        label: "Stage 6"
      }
      when: {
        sql: ${stage_name} = 'Stage 7' ;;
        label: "Closed Won"
      }
      else: "Unknown"
    }
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
