view: table {
  derived_table: {
    indexes: ["id"]
    datagroup_trigger: test
    increment_key: "created_date"
    increment_offset: 5
    distribution_style: all
    explore_source: order_items {
      column: id { field: users.id }
      column: city { field: users.city }
      column: created_date { field: users.created_date }
      column: count { field: users.count }
    }
  }
  dimension: id {
    type: number
  }
  dimension: city {}
  dimension: created_date {
    type: date
  }
  dimension: count {
    type: number
  }
}
