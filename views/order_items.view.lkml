view: order_items {
  sql_table_name: public.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
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

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
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

  measure: total_revenue_conditional {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
    html: {% if value > 5000.00 %}
          <p style="color: white; background-color: ##FFC20A; margin: 0; border-radius: 5px; text-align:center">{{ rendered_value }}</p>
          {% elsif value > 3000.00 %}
          <p style="color: white; background-color: #0C7BDC; margin: 0; border-radius: 5px; text-align:center">{{ rendered_value }}</p>
          {% else %}
          <p style="color: white; background-color: #6D7170; margin: 0; border-radius: 5px; text-align:center">{{ rendered_value }}</p>
          {% endif %}
          ;;
  }
}
