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
       select (${orders.user_id}*${order_items.sale_price}) - sum(${users.age}) from `demo_db`.`order_items` where ${users.created_year} = EXTRACT(YEAR FROM "2017-10-1") GROUP BY ${orders.user_id}
         );;
  }
  measure:test2 {
    type:number
    sql: (
       select sum(${orders.user_id}*${order_items.sale_price}) - sum(${users.age}) from order_items where ${users.created_year} = EXTRACT(YEAR FROM CURRENT_DATE())
         );;
  }

}
