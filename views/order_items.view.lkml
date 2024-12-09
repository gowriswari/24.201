view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    #view_label: "items_id"
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }
  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }
  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }
  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }
  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }


  measure:test1 {
    type:number
    sql: (
       select sum(${orders.user_id}*${order_items.sale_price}) - sum(${users.age}) from `demo_db`.`order_items` where ${orders.date_year} = EXTRACT(YEAR FROM "2023-10-1") GROUP BY ${users.age}
         );;
  }
  measure:test2 {
    type:number
    sql: (
       select sum(${orders.user_id}*${order_items.sale_price}) - sum(${users.age}) from order_items where ${orders.date_year} = EXTRACT(YEAR FROM CURRENT_DATE())
         );;
  }
############################################################################################################

  measure: sale_price_sum {
    type: sum
    sql: case
             when ${sale_price} = '{% parameter sale_price_metric_picker %}'
          then 1
          else 0
        END;;
  }


  parameter: sale_price_metric_picker {
    description: "Use with the Sale Price Metric measure"
    type: number
    }
  measure: dynamic_sum {
    type: sum
    sql: ${TABLE}.{% parameter para1 %} ;;
  }

  parameter: para1 {
    type: unquoted
    allowed_value: {
      label: "sales_sum"
      value: "sale_price"
    }
    allowed_value: {
      label: "order_id_sum"
      value: "order_id"
    }
  }
  measure: liquid_condition_check {
    type: number
    sql:${TABLE}.id = {% condition liquid_condition_check1 %} order_items.id {% endcondition %};;
  }
  filter: liquid_condition_check1 {
    type: number
  }

}
