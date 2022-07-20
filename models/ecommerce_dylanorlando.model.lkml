connection: "thelook"

# include all the views
include: "/views/**/*.view"

datagroup: ecommerce_dylanorlando_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
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
    sql_on: ${products.brand}.product_brand} = ${brand_order_facts.brand} ;;
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

explore: product_facts {
  join: products {
    type: left_outer
    sql_on: ${product_facts.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: users {}
