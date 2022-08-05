include: "/views/users.view.lkml"

view: +users {
  dimension: age {
    type: number
    sql: ${TABLE}.age*20 ;;
  }

 }
