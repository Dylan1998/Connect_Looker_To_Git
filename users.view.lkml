include: "/views/users.view.lkml"

view: +users {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    hidden: yes
    type: number
    sql: ${TABLE}.age ;;
  }

 }
