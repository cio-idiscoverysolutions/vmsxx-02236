view: i_ds_day_in_life {
  sql_table_name: dbo.iDS_day_in_life ;;

  dimension: custodian {
    type: string
    sql: ${TABLE}.custodian ;;
  }

  dimension_group: date_beg_source {
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
    sql: ${TABLE}.date_beg_source ;;
  }

  measure: most_recent_date {
    type: time
    sql: MAX(${date_beg_source_time});;
  }

  measure: earliest_date {
    type: time
    sql: MIN(${date_beg_source_time});;
  }

  dimension: evt_num  {
    type:  number
    sql: ${TABLE}.evt_num ;;
  }

  dimension: evt_type {
    type: string
    sql: ${TABLE}.evt_type ;;
  }

  dimension: evt_group {
    type: string
    sql: ${TABLE}.evt_group ;;
  }

  dimension: file_of_interest_ind {
    type: number
    sql: ${TABLE}.file_of_interest_ind ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.NOTES ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: source_file {
    type: string
    sql: ${TABLE}.source_file ;;
  }

  dimension: udf_id {
    type: number
    sql: ${TABLE}.UDF_ID ;;
  }

  dimension: file_extension {
    type:  string
    sql: ${TABLE}.file_extension ;;
  }


  measure: count {
    type: count
    drill_fields: []
  }
}
