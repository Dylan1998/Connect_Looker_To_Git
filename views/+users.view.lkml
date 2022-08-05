include: "/views/users.view.lkml"

view: +users {
  dimension: age {
    hidden: yes
    type: number
    sql: ${TABLE}.age ;;
  }

 }
