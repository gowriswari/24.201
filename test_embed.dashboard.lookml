---
- dashboard: spider_vis
  title: spider_vis
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: Jex79w86LEQQRuuRfp05yO
  elements:
  - title: spider_vis
    name: spider_vis
    model: arturo_thelook
    explore: order_items
    type: test_project11::spider-manual-upload
    fields: [orders.count, products.count, order_items.count, users.gender]
    sorts: [orders.count desc 0]
    limit: 500
    column_limit: 50
    query_timezone: UTC
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    defaults_version: 0
    hidden_pivots: {}
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 12
