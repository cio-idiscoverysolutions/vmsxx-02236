view: vmsxx_02236_cda_0010_v2 {
  derived_table: {
    sql: Select c.DESCRIPTION 'CDA Name'
        , cr.RESULTS_NUM_VALUE 'Risk Level'
        --, o.OBJ_ID
        , o.NAME 'File/Folder'
      --  , u.UDF_ID
        , u.DATE_BEG_source 'Activity Date'
        , p.FULL_NAME
        , e.NAME As 'Event'
        , s.notes as 'Custodian'
        , o.notes as 'URL'
        , substring(o.notes, charindex('//', o.notes), charindex('/', o.notes, charindex('//', o.notes)+2) - charindex('//', o.notes)) as domain
      --Select distinct convert(Date, date_beg_source)
      From cda.CDA_RESULTS cr
        Inner Join cda.CDA c
          ON cr.CDA_ID = c.CDA_ID
        Inner Join udf.UDF u
          ON cr.UDF_ID = u.UDF_ID
        Inner Join dim.OBJ o
          ON o.OBJ_ID = u.OBJ_ID
        Inner Join dim.EVT e
          ON e.EVT_ID = u.EVT_ID
        Inner Join dim.PPL p
          ON p.PPL_ID = u.PPL_ID
        Inner Join dim.src s
          on u.src_id = s.src_id
      Where cr.CDA_ID = 10
      and substring(o.notes, charindex('//', o.notes), charindex('/', o.notes, charindex('//', o.notes)+2) - charindex('//', o.notes)) not in
        (
        '//107-coj-713.mktoresp.com'
        , '//bam.nr-data.net'
        , '//ml314.com'
        , '//www.facebook.com'
        , '//8166291.fls.doubleclick.net'
        , '//dc.ads.linkedin.com'
        , '//googleads.g.doubleclick.net'
        , '//px.ads.linkedin.com'
        , '//sp.analytics.yahoo.com'
        , '//us-east-1.dc.ads.linkedin.com'
        , '//www.bizographics.com'
        , '//www.facebook.com'
        , '//www.google.com'
        )
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: number_of_unique_visits {
    type: count_distinct
    sql: ${activity_date_time} ;;
  }

  dimension: cda_name {
    type: string
    label: "CDA Name"
    sql: ${TABLE}."CDA Name" ;;
  }

  dimension: risk_level {
    type: string
    label: "Risk Level"
    sql: ${TABLE}."Risk Level" ;;
  }

  dimension: filefolder {
    type: string
    sql: ${TABLE}."File/Folder" ;;
  }

  dimension_group: activity_date {
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
    sql: ${TABLE}."Activity Date" ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.FULL_NAME ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.Event ;;
  }

  dimension : custodian {
    type:  string
    full_suggestions: yes
    bypass_suggest_restrictions: yes
    sql:  ${TABLE}.Custodian ;;
  }

  dimension : url {
    type:  string
    sql:  ${TABLE}.url ;;
  }

  dimension : domain {
    type:  string
    full_suggestions: yes
    bypass_suggest_restrictions: yes
    sql:  ${TABLE}.domain ;;
  }

  set: detail {
    fields: [
      cda_name,
      risk_level,
      filefolder,
      activity_date_raw,
      activity_date_time,
      activity_date_date,
      activity_date_week,
      activity_date_month,
      activity_date_quarter,
      activity_date_year,
      full_name,
      event
    ]
  }
}
