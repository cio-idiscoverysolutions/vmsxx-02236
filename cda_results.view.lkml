view: cda_results {
  sql_table_name: cda.CDA_RESULTS ;;

  dimension: cda_results_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.CDA_RESULTS_ID ;;
  }

  dimension: cda_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.CDA_ID ;;
  }

  dimension: results_notes {
    type: string
    sql: ${TABLE}.RESULTS_NOTES ;;
  }

  dimension: results_value {
    type: string
    sql: ${TABLE}.RESULTS_VALUE ;;
  }

  dimension: results_num_value {
    type: number
    sql: ${TABLE}.RESULTS_NUM_VALUE ;;
  }

  dimension: udf_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.UDF_ID ;;
  }
  dimension: ppl_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.PPL_ID ;;
  }
  dimension: obj_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.OBJ_ID ;;
  }
  dimension: loc_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.LOC_ID ;;
  }
  dimension: evt_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.EVT_ID ;;
  }
  measure: count {
    type: count
    drill_fields: [cda_results_id, cda.cda_id, cda.name, udf.udf_id]
  }
  dimension: risk {
    sql: CASE WHEN ${results_num_value} = 0  THEN 'High/USB insertion'
              WHEN ${results_num_value} = 10  THEN 'Medium/File activity on USB'
              WHEN ${results_num_value} = 50  THEN 'Low/Other file activity''
              ELSE 'Undetermined'
         END ;;
  }
}
