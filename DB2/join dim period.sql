SELECT
    sd.*,
    sc.*,
    CASE
        WHEN sc.start_date <= sd.start_date THEN sd.start_date
        ELSE sc.start_date
    END fstart_date,
    CASE
        WHEN sc.end_date >= sd.end_date THEN sd.end_date
        ELSE sc.end_date
    END fend_date
FROM
    sale_valid_dep_dim sd
    INNER JOIN sale_valid_city_dim sc ON sd.sales_id = sc.sales_id
and ( sd.start_date,
      ( sd.end_date - 1 )) overlaps(sc.start_date,(sc.end_date - 1))
order BY sd.sales_id,
                                                                               fstart_date,
                                                                               fend_date