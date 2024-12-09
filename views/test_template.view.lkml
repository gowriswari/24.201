
view: test_template {
  derived_table: {
    sql: SELECT
          users.id  AS `users.id`,
          users.age  AS `users.age`
      FROM demo_db.orders  AS orders
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id
        WHERE {% condition users_city %} users.city {% endcondition %}
      GROUP BY
          1
      LIMIT 500 ;;
  }
  dimension: users_id {
    type: number
    sql: ${TABLE}.`users.id` ;;
  }

  dimension: users_age {
    type: number
    sql: ${TABLE}.`users.age` ;;
  }
  filter: users_city{
    type: string
    #sql: ${users_city} ;;
  }
}
 #WHERE (users.city ) = 'Ada'
