connection: "thelook"

#probando
# include all the views
include: "/views/**/*.view"


datagroup: ecommerce_dylanorlando_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}
datagroup: test {
  sql_trigger: SELECT (EXTRACT MONTH FROM CURRENT_TIMESTAMP() )  ;;
  max_cache_age: "2 hours"
}
datagroup: cache {
  sql_trigger: SELECT (EXTRACT DAY FROM CURRENT_TIMESTAMP() )  ;;
  max_cache_age: "24 hours"
}



datagroup: cat {
  sql_trigger: SELECT (EXTRACT MONTH FROM CURRENT_TIMESTAMP() )  ;;
  max_cache_age: "2 hours"
}
persist_with: ecommerce_dylanorlando_default_datagroup

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: users_location {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: user_facts {
    type: left_outer
    sql_on: ${order_items.order_id} = ${user_facts.order_items_order_id};;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: brand_order_facts {
    type: left_outer
    sql_on: ${products.brand} = ${brand_order_facts.brand} ;;
    relationship: many_to_one
  }
}



explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders_session {
  description: "Start here for Event analysis"
  fields: [ALL_FIELDS*]
  from: orders_session
  view_name: orders_session
  extends: [base_orders]
  join: users {
    type: left_outer
    sql_on: ${orders_session.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: product_facts {
  join: products {
    type: left_outer
    sql_on: ${product_facts.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: users_location  {

}

explore: base_orders {
  extension: required
  join: users_location {
    type: left_outer
    sql_on: ${orders_session.user_id} = ${users_location.id} ;;
    relationship: many_to_one
  }
}

explore: conversions {
  description: "Start here for Conversion Analysis"
  fields: [ALL_FIELDS*, -order_items.total_sales]
  from: orders_session
  view_name: orders_session
  extends: [base_orders]
  join: order_items {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders_session.id} ;;
    relationship: many_to_many
  }
}

explore: user_facts {}

explore: products {}

explore: users {}

explore: table {}

#explore: +users {}
