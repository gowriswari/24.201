
view: users {
  #extends:[assessment]
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    html:  {% if value =="Australia" %}
          <p><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Flag_of_Australia_%28converted%29.svg/383px-Flag_of_Australia_%28converted%29.svg.png" </p>
          {% elsif value == "Austria" %} <p><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Flag_of_Austria_%28state%29.svg/237px-Flag_of_Austria_%28state%29.svg.png"} </p>

        {% endif %};;
  }


  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: data_test{
   # type: date_time
    sql: SELECT DATE(NOW());;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }
  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }
  measure: test {
    type: sum
    sql: case
    when ${age} = '{% parameter age_sum %}'
      THEN 1
      ELSE 0
    END;;
  }
  parameter: age_sum {
    type: unquoted
  }
  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  first_name,
  last_name,
  events.count,
  orders.count,
  saralooker.count,
  sindhu.count,
  user_data.count
  ]
  }

}
