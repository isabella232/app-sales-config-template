- dashboard: sales_app_audit
  title: Sales App Audit
  layout: newspaper
  elements:
  - title: Rep Quotas (This Quarter)
    name: Rep Quotas (This Quarter)
    model: sales_analytics
    explore: opportunity
    type: table
    fields: [opportunity_owner.name, opportunity_owner.ae_segment, quota.quota_amount]
    filters:
      opportunity_owner.is_sales_rep: 'Yes'
      opportunity.close_fiscal_quarter: this fiscal quarter
    sorts: [opportunity_owner.name]
    limit: 500
    column_limit: 50
    color_application:
      collection_id: legacy
      palette_id: looker_classic
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      opportunity.total_new_closed_won_amount_qtd: Closed Won
      opportunity.total_pipeline_amount: Pipeline
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging1,
          options: {steps: 5, __FILE: app-sales/sales_rep_overview.dashboard.lookml,
            __LINE_NUM: 116}, __FILE: app-sales/sales_rep_overview.dashboard.lookml,
          __LINE_NUM: 115}, bold: false, italic: false, strikethrough: false, fields: [],
        __FILE: app-sales/sales_rep_overview.dashboard.lookml, __LINE_NUM: 114}, {
        type: less than, value: 1, background_color: "#F36254", font_color: !!null '',
        color_application: {collection_id: legacy, palette_id: legacy_diverging1,
          options: {steps: 5, constraints: {max: {type: number, value: 0.1, __FILE: app-sales/sales_rep_overview.dashboard.lookml,
                __LINE_NUM: 122}, min: {type: number, value: 0, __FILE: app-sales/sales_rep_overview.dashboard.lookml,
                __LINE_NUM: 123}, mid: {type: number, value: 0.5, __FILE: app-sales/sales_rep_overview.dashboard.lookml,
                __LINE_NUM: 124}, __FILE: app-sales/sales_rep_overview.dashboard.lookml,
              __LINE_NUM: 122}, __FILE: app-sales/sales_rep_overview.dashboard.lookml,
            __LINE_NUM: 122}, __FILE: app-sales/sales_rep_overview.dashboard.lookml,
          __LINE_NUM: 121}, bold: false, italic: false, strikethrough: false, fields: [],
        __FILE: app-sales/sales_rep_overview.dashboard.lookml, __LINE_NUM: 120}, {
        type: between, value: [1, 2], background_color: "#FCF758", font_color: !!null '',
        color_application: {collection_id: legacy, palette_id: legacy_diverging1,
          __FILE: app-sales/sales_rep_overview.dashboard.lookml, __LINE_NUM: 131},
        bold: false, italic: false, strikethrough: false, fields: [], __FILE: app-sales/sales_rep_overview.dashboard.lookml,
        __LINE_NUM: 130}, {type: greater than, value: 2, background_color: "#4FBC89",
        font_color: !!null '', color_application: {collection_id: legacy, palette_id: legacy_diverging1,
          __FILE: app-sales/sales_rep_overview.dashboard.lookml, __LINE_NUM: 135},
        bold: false, italic: false, strikethrough: false, fields: [], __FILE: app-sales/sales_rep_overview.dashboard.lookml,
        __LINE_NUM: 134}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    subtotals_at_bottom: false
    series_types: {}
    hidden_fields: []
    listen: {}
    row: 9
    col: 2
    width: 10
    height: 8
  - title: Business Segments
    name: Business Segments
    model: sales_analytics
    explore: account
    type: table
    fields: [account.business_segment]
    fill_fields: [account.business_segment]
    limit: 500
    series_types: {}
    listen: {}
    row: 17
    col: 12
    width: 10
    height: 8
  - title: Opportunity Types
    name: Opportunity Types
    model: sales_analytics
    explore: opportunity
    type: table
    fields: [opportunity.type, opportunity.is_included_in_quota, opportunity.is_new_business,
      opportunity.is_renewal_upsell]
    sorts: [opportunity.type]
    limit: 500
    series_types: {}
    listen: {}
    row: 17
    col: 2
    width: 10
    height: 8
  - title: Total Bookings (YTD)
    name: Total Bookings (YTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_closed_won_new_business_amount]
    filters:
      opportunity.close_date: before 0 minutes ago
      opportunity.close_fiscal_quarter: this fiscal year
    limit: 1000
    column_limit: 50
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs. Last Quarter
    filter_expression: |-
      # Only compare QTDs
      ${opportunity.day_of_fiscal_quarter} <= ${opportunity.current_day_of_fiscal_quarter}
    font_size: medium
    text_color: black
    hidden_fields: [opportunity.total_closed_won_revenue, change, yoy_change]
    note_state: collapsed
    note_display: hover
    note_text: Total amount produced by quota-bearing deals this fiscal year.
    listen: {}
    row: 0
    col: 12
    width: 10
    height: 3
  - title: Pipeline (YTD)
    name: Pipeline (YTD)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount]
    filters:
      opportunity.created_date: this fiscal year
      opportunity.created_time: before 0 minutes ago
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields: [quota_numbers.quarterly_aggregate_quota_measure]
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: Total amount of ongoing deals created this fiscal year (i.e. total
      amount in the pipeline)
    listen: {}
    row: 3
    col: 12
    width: 10
    height: 3
  - title: Number of Customers (All-Time)
    name: Number of Customers (All-Time)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.count_customers]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: ''
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: New Customers - YTD
    font_size: small
    hidden_fields:
    listen: {}
    row: 6
    col: 12
    width: 10
    height: 3
  - title: Rep Quotas (Full Derived Table)
    name: Rep Quotas (Full Derived Table)
    model: sales_analytics
    explore: quota
    type: table
    fields: [quota.name, quota.ae_segment, quota.quota_amount, quota.quota_start_date]
    sorts: [quota.name, quota.quota_start_date]
    limit: 500
    query_timezone: UTC
    series_types: {}
    listen: {}
    row: 9
    col: 12
    width: 10
    height: 8
  - title: Total Bookings (Last Quarter)
    name: Total Bookings (Last Quarter)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_closed_won_new_business_amount]
    filters:
      opportunity.close_fiscal_quarter: last fiscal quarter
    limit: 1000
    column_limit: 50
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: ''
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: vs. Last Quarter
    filter_expression: |-
      # Only compare QTDs
      ${opportunity.day_of_fiscal_quarter} <= ${opportunity.current_day_of_fiscal_quarter}
    font_size: medium
    text_color: black
    hidden_fields: [opportunity.total_closed_won_revenue, change, yoy_change]
    note_state: collapsed
    note_display: hover
    note_text: Total amount produced by quota-bearing deals last fiscal quarter.
    listen: {}
    row: 0
    col: 2
    width: 10
    height: 3
  - title: Pipeline (Last Quarter)
    name: Pipeline (Last Quarter)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [opportunity.total_pipeline_new_business_amount]
    filters:
      opportunity.created_date: last quarter
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields: [quota_numbers.quarterly_aggregate_quota_measure]
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: Total amount of ongoing deals created last fiscal quarter (i.e. total
      amount in the pipeline)
    listen: {}
    row: 3
    col: 2
    width: 10
    height: 3
  - title: Number of Customers (Last Quarter)
    name: Number of Customers (Last Quarter)
    model: sales_analytics
    explore: opportunity
    type: single_value
    fields: [account.count_customers]
    filters:
      opportunity.close_date: last fiscal quarter
      opportunity.is_new_business: 'Yes'
      opportunity.is_won: 'Yes'
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    single_value_title: ''
    show_comparison: false
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    comparison_label: New Customers - YTD
    font_size: small
    hidden_fields:
    listen: {}
    row: 6
    col: 2
    width: 10
    height: 3
