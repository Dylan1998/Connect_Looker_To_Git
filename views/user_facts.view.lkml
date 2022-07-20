view: sql_runner_query {
  derived_table: {
    sql: SELECT
          "order_id" AS "order_items.order_id",
              (DATE(MIN(DATE(order_items.returned_at )))) AS "order_items.first_returned_date",
              (DATE(MAX(DATE(order_items.returned_at )))) AS "order_items.latest_returned_date",
          COUNT(DISTINCT "order_id") AS "order_items.count_distinct_orders",
          COUNT(*) AS "order_items.count",
          COALESCE(SUM(CAST(order_items.sale_price AS DOUBLE PRECISION)), 0) AS "sum_of_sale_price"
      FROM
          "public"."order_items" AS "order_items"
      GROUP BY
          1
      HAVING (((( MIN((DATE(order_items.returned_at )))  )) IS NOT NULL)) AND (((( MAX((DATE(order_items.returned_at )))  )) IS NOT NULL))
      ORDER BY
          2 DESC
       ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."order_items.order_id" ;;
  }

  dimension: order_items_first_returned_date {
    type: date
    sql: ${TABLE}."order_items.first_returned_date" ;;
  }

  dimension: order_items_latest_returned_date {
    type: date
    sql: ${TABLE}."order_items.latest_returned_date" ;;
  }

  dimension: order_items_count_distinct_orders {
    type: number
    sql: ${TABLE}."order_items.count_distinct_orders" ;;
  }

  dimension: order_items_count {
    type: number
    sql: ${TABLE}."order_items.count" ;;
  }

  dimension: sum_of_sale_price {
    type: number
    sql: ${TABLE}.sum_of_sale_price ;;
  }

  set: detail {
    fields: [
      order_items_order_id,
      order_items_first_returned_date,
      order_items_latest_returned_date,
      order_items_count_distinct_orders,
      order_items_count,
      sum_of_sale_price
    ]
  }
}
