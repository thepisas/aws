--DROP VIEW edh.cva_view_tableau;
CREATE OR REPLACE VIEW edh.cva_view_tableau AS
 SELECT customer_visual_analytics.ecm_cust_id, customer_visual_analytics.spend_lifetime, customer_visual_analytics.gender, customer_visual_analytics.date_of_birth, customer_visual_analytics.age_band, customer_visual_analytics.postal_code, customer_visual_analytics.customer_country, customer_visual_analytics.allow_email, customer_visual_analytics.allow_phone, customer_visual_analytics.allow_mail, customer_visual_analytics.cic_flag, customer_visual_analytics.first_purchase_date, customer_visual_analytics.customer_profile, customer_visual_analytics.household_id, customer_visual_analytics.householdflag, customer_visual_analytics.ecm_active_flag, customer_visual_analytics.we_net_worth, customer_visual_analytics.marital_status, customer_visual_analytics.household_income, customer_visual_analytics.mb_primary_segment_description, customer_visual_analytics.fin_product_family, customer_visual_analytics.fin_product_subfamily, customer_visual_analytics.department, customer_visual_analytics.financial_product_category, customer_visual_analytics.merch_collection, customer_visual_analytics.product_type, customer_visual_analytics.sku, customer_visual_analytics.channel, customer_visual_analytics."location", customer_visual_analytics.mips_store_number, customer_visual_analytics.store_country, customer_visual_analytics.global_region, customer_visual_analytics.global_sub_region, customer_visual_analytics."region", customer_visual_analytics.store_city, customer_visual_analytics.store_postal_code, customer_visual_analytics.store_latitude, customer_visual_analytics.store_longitude, customer_visual_analytics.currency_code, customer_visual_analytics.gl_date, customer_visual_analytics.fiscal_year, customer_visual_analytics.fiscal_month, customer_visual_analytics.extended_price_usd, customer_visual_analytics.extended_price_lc, customer_visual_analytics.total_sales_amount_with_tax_usd, customer_visual_analytics.total_sales_amount_with_tax_lc, customer_visual_analytics.units, customer_visual_analytics.invoice_number, customer_visual_analytics.price_point_usd, customer_visual_analytics.price_point_lc, customer_visual_analytics.price_point_with_tax_usd, customer_visual_analytics.price_point_with_tax_lc, customer_visual_analytics.tourism_type, customer_visual_analytics.historical_tr_level, customer_visual_analytics.eng_flag_pos, customer_visual_analytics.registered_customer_flag, customer_visual_analytics.transaction_key, customer_visual_analytics.return_transaction_key, customer_visual_analytics.current_tr_level
   FROM edh.customer_visual_analytics;
--DROP VIEW edh.v_biweekly_periods;
CREATE OR REPLACE VIEW edh.v_biweekly_periods AS
 SELECT biweekly_period.period, biweekly_period.period_max_date_key, biweekly_period.period_max_date_dt, pg_catalog.row_number()
  OVER( 
  ORDER BY biweekly_period.period) AS seqno
   FROM ( SELECT "substring"(date.date_cymd_nbr::character varying::text, 1, 6) || 
                CASE
                    WHEN "substring"(date.date_cymd_nbr::character varying::text, 7, 2) < 16::character varying::text THEN 1
                    ELSE 2
                END::character varying::text AS period, "max"(date.date_key) AS period_max_date_key, "max"(date.date_dt) AS period_max_date_dt
           FROM edh.date_dim date
          WHERE date.date_dd_nbr <> 0
          GROUP BY "substring"(date.date_cymd_nbr::character varying::text, 1, 6) || 
                CASE
                    WHEN "substring"(date.date_cymd_nbr::character varying::text, 7, 2) < 16::character varying::text THEN 1
                    ELSE 2
                END::character varying::text
          ORDER BY "substring"(date.date_cymd_nbr::character varying::text, 1, 6) || 
                CASE
                    WHEN "substring"(date.date_cymd_nbr::character varying::text, 7, 2) < 16::character varying::text THEN 1
                    ELSE 2
                END::character varying::text) biweekly_period;
--DROP VIEW edh.v_cd100_clerk_dim_distinct;
CREATE OR REPLACE VIEW edh.v_cd100_clerk_dim_distinct AS
 SELECT clrk.clerk_key, clrk.source_clerk_key, clrk.clerk_id, clrk.active_record_ind, clrk.clerk_first_nm, clrk.clerk_last_nm, clrk.clerk_class_txt, clrk.employee_nbr, clrk.company_nbr, clrk.channel_type, clrk.floor_txt, clrk.job_cd, clrk.commisionable_ind, clrk.clerk_status_txt, clrk.status_dt, clrk.store_nbr, clrk.iso_country_cd, clrk.iso_country_nm, clrk.country_display_nm, clrk.location_nm, clrk.region_nm, clrk.effective_tmstmp, clrk.expiration_tmstmp, clrk.current_ind, clrk.mapping_nm, clrk.create_tmstmp, clrk.update_tmstmp, clrk.workflow_instance_id, ecpclrk.employeeno, ecpclrk.clerkid, ecpclrk.store_number, ecpclrk.last_update
   FROM edh.clerk_dim clrk
   JOIN edh.lookup_ecpclrk ecpclrk ON ltrim(clrk.employee_nbr::text, '0'::character varying::text) = ltrim(ecpclrk.employeeno::text, '0'::character varying::text) AND clrk.clerk_id = ecpclrk.clerkid AND clrk.store_nbr = ecpclrk.store_number;
--DROP VIEW edh.v_cd100_current_date_record;
CREATE OR REPLACE VIEW edh.v_cd100_current_date_record AS
 SELECT curr_date.date_key AS curr_date_key, py_date.date_key AS py_date_key, eop_date.date_key AS eop_date_key, py_eop_date.date_key AS py_eop_date_key
   FROM edh.date_dim curr_date
   JOIN edh.date_dim py_date ON curr_date.date_dt::timestamp without time zone = date_add('year'::text, (+ 1)::bigint, py_date.date_dt::timestamp without time zone)
   JOIN ( SELECT v_biweekly_periods.period_max_date_key AS date_key
      FROM edh.v_biweekly_periods
     WHERE v_biweekly_periods.seqno = (( SELECT v_biweekly_periods.seqno - 1
              FROM edh.v_biweekly_periods
             WHERE v_biweekly_periods.period = (( SELECT "substring"(curdate.date_cymd_nbr::text, 1, 6) || 
                           CASE
                               WHEN "substring"(curdate.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                               ELSE 2
                           END::text AS period
                      FROM edh.date_dim curdate
                     WHERE curdate.date_dt = (( SELECT 'now'::character varying::date AS date))))))) eop_date ON true
   JOIN ( SELECT v_biweekly_periods.period_max_date_key AS date_key
   FROM edh.v_biweekly_periods
  WHERE v_biweekly_periods.seqno = (( SELECT v_biweekly_periods.seqno - 1
           FROM edh.v_biweekly_periods
          WHERE v_biweekly_periods.period = (( SELECT "substring"(pydate.date_cymd_nbr::text, 1, 6) || 
                        CASE
                            WHEN "substring"(pydate.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                            ELSE 2
                        END::text AS period
                   FROM edh.date_dim pydate
                  WHERE pydate.date_dt = date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))))) py_eop_date ON true
  WHERE curr_date.date_dt = 'now'::character varying::date;
--DROP VIEW edh.v_cd100_current_date_record_txt;
CREATE OR REPLACE VIEW edh.v_cd100_current_date_record_txt AS
 SELECT curr_dt.date_key AS curr_date_key, py_dt.date_key AS py_date_key, curr_eop_dt.date_key AS curr_eop_date_key, py_eop_dt.date_key AS py_eop_date_key, curr_dt.date_dt AS curr_date_dt, py_dt.date_dt AS py_date_dt, curr_eop_dt.date_dt AS curr_eop_date_dt, py_eop_dt.date_dt AS py_eop_date_dt, curr_dt.date_fiscal_year_txt AS curr_fy_txt, py_dt.date_fiscal_year_txt AS py_fy_txt, (((curr_eop_dt.date_fiscal_year_txt::text || '/'::text) || curr_eop_dt.date_mm_nbr::text) || '/'::text) || curr_eop_dt.date_dd_nbr::text AS period_end_date, (((py_eop_dt.date_fiscal_year_txt::text || '/'::text) || py_eop_dt.date_mm_nbr::text) || '/'::text) || py_eop_dt.date_dd_nbr::text AS py_period_end_date, (curr_eop_dt.date_fiscal_month_txt::text || '/'::text) || 
        CASE
            WHEN "substring"(curr_eop_dt.date_cymd_nbr::character varying::text, 7, 2) < 16::character varying::text THEN 1
            ELSE 2
        END::character varying::text AS date_fiscal_bimonth_period_txt, (py_eop_dt.date_fiscal_month_txt::text || '/'::text) || 
        CASE
            WHEN "substring"(py_eop_dt.date_cymd_nbr::character varying::text, 7, 2) < 16::character varying::text THEN 1
            ELSE 2
        END::character varying::text AS py_fiscal_bimonth_period_txt
   FROM edh.v_cd100_current_date_record cdr
   JOIN edh.date_dim curr_dt ON cdr.curr_date_key = curr_dt.date_key
   JOIN edh.date_dim py_dt ON cdr.py_date_key = py_dt.date_key
   JOIN edh.date_dim curr_eop_dt ON cdr.eop_date_key = curr_eop_dt.date_key
   JOIN edh.date_dim py_eop_dt ON cdr.py_eop_date_key = py_eop_dt.date_key;
--DROP VIEW edh.v_cd100_date_dim;
CREATE OR REPLACE VIEW edh.v_cd100_date_dim AS
 SELECT (date.date_fiscal_month_txt::text || '/'::text) || 
        CASE
            WHEN "substring"(date.date_cymd_nbr::character varying::text, 7, 2) < 16::character varying::text THEN 1
            ELSE 2
        END::character varying::text AS date_fiscal_bimonth_period_txt, date.date_key, date.source_date_key, date.date_yyyy_nbr, date.date_month_txt, date.date_day_txt, date.date_year_454_txt, date.date_month_454_txt, date.date_week_454_txt, date.date_day_of_week_454_txt, date.date_fiscal_year_txt, date.date_fiscal_month_txt, date.date_fiscal_quarter_txt, date.date_holiday_season_ind, date.date_cymd_nbr, date.date_cc_nbr, date.date_yy_nbr, date.date_mm_nbr, date.date_dd_nbr, date.date_mips_week_454_txt, date.date_dt, date.date_julian_calendar_nbr, date.effective_tmstmp, date.expiration_tmstmp, date.current_ind, date.mapping_nm, date.create_tmstmp, date.update_tmstmp, date.workflow_instance_id
   FROM edh.date_dim date;
--DROP VIEW edh.v_cd100_ecpclrk_tmp;
CREATE OR REPLACE VIEW edh.v_cd100_ecpclrk_tmp AS
 SELECT emp.employeeno AS employee_no, emp.clerkid AS clerk_id, emp.storeno AS store_number, emp.datelastmodified AS last_update
   FROM ( SELECT pg_catalog.row_number()
          OVER( 
          PARTITION BY stg_auth_employee.employeeno
          ORDER BY stg_auth_employee.datelastmodified DESC, stg_auth_employee.applicationid) AS row_number, stg_auth_employee.employeeno, stg_auth_employee.clerkid, stg_auth_employee.storeno::integer AS storeno, stg_auth_employee.datelastmodified
           FROM edh.stg_auth_employee
          WHERE stg_auth_employee.employeeno IS NOT NULL AND COALESCE(stg_auth_employee.clerkid, 0::bigint) > 0 AND COALESCE(stg_auth_employee.storeno, ''::character varying)::text <> ''::text AND stg_auth_employee.isactive = 1) emp;
--DROP VIEW edh.v_cd100_portcust_sp;
CREATE OR REPLACE VIEW edh.v_cd100_portcust_sp AS
 SELECT cl.clerk_key AS assigned_clerk_key, cl.employee_nbr, cl.store_nbr, cu.client_type_dscr, count(cu.customer_key) AS customer_cnt, d.date_key AS report_date_key, chnl.channel_key AS assigned_channel_key
   FROM edh.customer_dim cu
   LEFT JOIN edh.v_cd100_clerk_dim_distinct cl ON ltrim(cu.assigned_employee_cd::text, '0'::character varying::text) = ltrim(cl.employee_nbr::text, '0'::character varying::text)
   LEFT JOIN edh.date_dim d ON d.date_dt = 'now'::character varying::date
   LEFT JOIN edh.cd100_ref_chnl_key_lkp_tmp chnl_lu ON chnl_lu.financial_location::text = cl.store_nbr::text AND chnl_lu.channel::text = 'IV'::text
   LEFT JOIN edh.channel_dim chnl ON chnl.channel_key::text = chnl_lu.channel_dim_channel_key::text
  WHERE cu.assigned_employee_cd IS NOT NULL AND (cu.client_type_dscr::text = 'Portfolio'::character varying::text OR cu.client_type_dscr::text = 'Portfolio Bridal'::character varying::text) AND cu.employee_ind = 0 AND cu.crm_system_id = 1 AND COALESCE(chnl.iso_country_nm, ''::character varying)::text <> 'Japan'::text AND COALESCE(chnl.iso_country_nm, ''::character varying)::text <> 'Brazil'::text AND COALESCE(chnl.iso_country_nm, ''::character varying)::text <> 'Russia'::text
  GROUP BY cl.clerk_key, cl.employee_nbr, cl.store_nbr, cu.client_type_dscr, d.date_key, chnl.channel_key;
--DROP VIEW edh.v_cd100_portfolio_customers;
CREATE OR REPLACE VIEW edh.v_cd100_portfolio_customers AS
 SELECT d.date_key AS report_date_key, cu.customer_key AS portfolio_customer_key, cl.clerk_key AS assigned_clerk_key, chnl.channel_key AS assigned_channel_key
   FROM edh.customer_dim cu
   LEFT JOIN edh.v_cd100_clerk_dim_distinct cl ON ltrim(cu.assigned_employee_cd::text, '0'::character varying::text) = ltrim(cl.employee_nbr::text, '0'::character varying::text)
   LEFT JOIN edh.date_dim d ON d.date_dt = 'now'::character varying::date
   LEFT JOIN edh.cd100_ref_chnl_key_lkp_tmp chnl_lu ON chnl_lu.financial_location::text = cl.store_nbr::character varying::text AND chnl_lu.channel::text = 'IV'::character varying::text
   LEFT JOIN edh.channel_dim chnl ON chnl.channel_key::character varying::text = chnl_lu.channel_dim_channel_key::text
  WHERE cu.assigned_employee_cd IS NOT NULL AND (cu.client_type_dscr::text = 'Portfolio'::character varying::text OR cu.client_type_dscr::text = 'Portfolio Bridal'::character varying::text) AND cu.employee_ind = 0 AND cu.crm_system_id = 1 AND COALESCE(chnl.iso_country_nm, ''::character varying)::text <> 'Japan'::character varying::text AND COALESCE(chnl.iso_country_nm, ''::character varying)::text <> 'Brazil'::character varying::text AND COALESCE(chnl.iso_country_nm, ''::character varying)::text <> 'Russia'::character varying::text;
--DROP VIEW edh.v_cd100_portsales_repeat_cust;
CREATE OR REPLACE VIEW edh.v_cd100_portsales_repeat_cust AS
 SELECT derived_table1.report_date_time, derived_table1.assigned_clerk_key, derived_table1.repeat_customer_key, derived_table1.assigned_channel_key, "max"(derived_table1.ppy_purchase_flag) AS ppy_purchase_flag, "max"(derived_table1.py_purchase_flag) AS py_purchase_flag, "max"(derived_table1.fytd_purchase_flag) AS fytd_purchase_flag, sum(derived_table1.ppy_total_sales) AS ppy_total_sales, sum(derived_table1.py_total_sales) AS py_total_sales, sum(derived_table1.fytd_total_sales) AS fytd_total_sales, ( SELECT date_dim.date_key
           FROM edh.date_dim
          WHERE date_dim.date_dt = (( SELECT "max"(a.period_end_date) AS last_pd_end_date
                   FROM ( SELECT "max"(d.date_dt) AS period_end_date, "substring"(d.date_cymd_nbr::text, 1, 6) AS period_yyyymm, 
                                CASE
                                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                                    ELSE 2
                                END AS month_half
                           FROM edh.date_dim d
                          WHERE d.date_dd_nbr <> 0
                          GROUP BY "substring"(d.date_cymd_nbr::text, 1, 6), 
                                CASE
                                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                                    ELSE 2
                                END) a
                  WHERE a.period_end_date < (( SELECT 'now'::character varying::date AS date))))) AS end_of_period_date_key
   FROM ( SELECT 'now'::text::timestamp with time zone::timestamp without time zone AS report_date_time, sp.clerk_key AS assigned_clerk_key, shf.customer_key AS repeat_customer_key, chnl.channel_key AS assigned_channel_key, sale_date.date_fiscal_year_txt AS fy_txt, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) THEN sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt)
                    ELSE 0::numeric
                END AS py_total_sales, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = date_add('year'::text, -2::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) THEN sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt)
                    ELSE 0::numeric
                END AS ppy_total_sales, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = (( SELECT 'now'::character varying::date AS date))))::text) THEN sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt)
                    ELSE 0::numeric
                END AS fytd_total_sales, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) AND sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt) > 0::numeric THEN 1
                    ELSE 0
                END AS py_purchase_flag, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = date_add('year'::text, -2::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) AND sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt) > 0::numeric THEN 1
                    ELSE 0
                END AS ppy_purchase_flag, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = (( SELECT 'now'::character varying::date AS date))))::text) AND sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt) > 0::numeric THEN 1
                    ELSE 0
                END AS fytd_purchase_flag
           FROM edh.v_cd100_clerk_dim_distinct sp
      LEFT JOIN ( SELECT cd.customer_key, cd.create_source_system_key, cd.update_source_system_key, cd.original_system_nm, cd.source_customer_key, cd.ecm_customer_id, cd.crm_system_id, cd.customer_nbr, cd.source_system_nm, cd.source_created_dt, cd.source_last_updt_dt, cd.client_type_id, cd.client_type_dscr, cd.assigned_employee_cd, cd.customer_title_txt, cd.customer_salutation_nm, cd.customer_first_nm, cd.customer_middle_nm, cd.customer_last_nm, cd.customer_suffix_txt, cd.customer_full_nm, cd.customer_post_nm, cd.employee_ind, cd.employee_nbr, cd.gender_nm, cd.birth_dt, cd.customer_marital_status_cd, cd.customer_marital_status_dscr, cd.customer_nationality, cd.first_purchase_dt, cd.last_purchased_dt, cd.spend_36_months_amt, cd.spend_lifetime_amt, cd.tr_cd, cd.tr_dscr, cd.ecm_active_ind, cd.cic_flg, cd.cic_updt_dt, cd.allow_mail_ind, cd.allow_email_ind, cd.allow_phone_ind, cd.allow_txt_ind, cd.address_ind, cd.email_ind, cd.phone_ind, cd.household_id, cd.household_dt, cd.household_salutation_txt, cd.household_relationship_type, cd.household_relationship_driver_ind, cd.address_line_1_txt, cd.address_line_2_txt, cd.address_line_3_txt, cd.address_line_4_txt, cd.building_nm, cd.building_2_nm, cd.city_nm, cd.city_2_nm, cd.city_3_nm, cd.city_4_nm, cd.province_nm, cd.state_nm, cd.district_cd, cd.display_country_nm, cd.country_iso_2_cd, cd.country_iso_nm, cd.postal_cd, cd.postal_1_cd, cd.postal_2_cd, cd.address_validation_ind, cd.customer_email_txt, cd.phone_nbr, cd.phone_country_dial_nbr, cd.phone_country_display_nm, cd.phone_country_iso_nm, cd.phone_country_iso_cd, cd.sms_phone_nbr, cd.sms_country_dial_nbr, cd.sms_country_display_nm, cd.sms_country_iso_nm, cd.sms_country_iso_cd, cd.ecm_originated_country_nm, cd.ecm_originated_country_cd, cd.jde_customer_cd, cd.account_source_nm, cd.marketing_cd, cd.marketing_dscr, cd.month_opened_nbr, cd.year_opened_nbr, cd.payment_option_nm, cd.search_type, cd.current_se_cd, cd.source_recipient_id, cd.recipient_black_list_email_sent_to_ecm_tmstmp, cd.recipient_black_list_email_sent_to_ecm_ind, cd.recipient_black_list_ind, cd.recipient_black_list_email_ind, cd.recipient_black_list_fax_ind, cd.recipient_black_list_mobile_ind, cd.recipient_black_list_phone_ind, cd.recipient_black_list_post_mail_ind, cd.recipient_computed_gender_code, cd.recipient_computed_gender_dscr, cd.recipient_ecard_opted_ind, cd.recipient_mbs_acclaim_customer_id, cd.recipient_mbs_pc7_b2b_customer_id, cd.recipient_mbs_pc7_b2c_customer_id, cd.recipient_black_list_postal_mail_reason_cd, cd.recipient_external_src_cd, cd.recipient_external_src_dscr, cd.recipient_src_file_nm, cd.recipient_outreach_country_numeric_cd, cd.recipient_outreach_country_dscr, cd.recipient_black_list_email_tmstmp, cd.recipient_black_list_postal_mail_tmstmp, cd.recipient_external_src_create_tmstmp, cd.recipient_external_src_update_tmstmp, cd.recipient_last_click_tmstmp, cd.recipient_last_modified_tmstmp, cd.recipient_last_opened_tmstmp, cd.recipient_japan_opt_in_cd, cd.recipient_japan_opt_in_dscr, cd.outreach_flg, cd.outreach_dscr, cd.recipient_external_src_database_nm, cd.recipient_external_src_database_dscr, cd.client_level_type_id, cd.client_level_type_dscr, cd.country_language_id, cd.country_language_dscr, cd.recipient_contact_preference_create_tmstmp, cd.recipient_contact_preference_update_tmstmp, cd.effective_tmstmp, cd.expiration_tmstmp, cd.current_ind, cd.mapping_nm, cd.create_tmstmp, cd.update_tmstmp, cd.workflow_instance_id
                   FROM edh.customer_dim cd
                  WHERE cd.client_type_dscr::text = 'Portfolio'::text OR cd.client_type_dscr::text = 'Portfolio Bridal'::text) portcust ON sp.employee_nbr::text = portcust.assigned_employee_cd::text
   LEFT JOIN edh.sales_history_fact shf ON portcust.customer_key = shf.customer_key
   JOIN edh.date_dim sale_date ON shf.invoice_date_key = sale_date.date_key
   LEFT JOIN edh.product_dim prdct ON shf.product_key = prdct.product_key
   LEFT JOIN edh.cd100_ref_chnl_key_lkp_tmp chnl_lu ON chnl_lu.financial_location::text = sp.store_nbr::text AND chnl_lu.channel::text = 'IV'::text
   LEFT JOIN edh.channel_dim chnl ON chnl_lu.channel_dim_channel_key::text = chnl.channel_key::text
  WHERE chnl.channel_nm::text <> 'Wholesale'::text AND chnl.channel_nm::text <> 'Corporate'::text AND prdct.sku_nbr > 10000000 AND prdct.department_nbr <> 401 AND prdct.department_nbr <> 409 AND prdct.department_nbr <> 410 AND prdct.financial_product_family_nm::text <> 'EMPLOYEE STORE'::text AND chnl.business_group_nm::text = 'Tiffany'::text AND (sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = (( SELECT 'now'::character varying::date AS date))))::text) OR sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) OR sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = date_add('year'::text, -2::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text)) AND chnl.sub_channel_nm::text <> 'Direct TFB'::text AND chnl.sub_channel_nm::text <> 'E-TFB'::text AND chnl.sub_channel_nm::text <> 'Retail TFB'::text AND portcust.employee_ind <> 1 AND sale_date.date_dt <= (( SELECT "max"(a.period_end_date) AS last_pd_end_date
   FROM ( SELECT "max"(d.date_dt) AS period_end_date, "substring"(d.date_cymd_nbr::text, 1, 6) AS period_yyyymm, 
                CASE
                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                    ELSE 2
                END AS month_half
           FROM edh.date_dim d
          WHERE d.date_dd_nbr <> 0
          GROUP BY "substring"(d.date_cymd_nbr::text, 1, 6), 
                CASE
                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                    ELSE 2
                END) a
  WHERE a.period_end_date < (( SELECT 'now'::character varying::date AS date))))
  GROUP BY sp.clerk_key, shf.customer_key, chnl.channel_key, sale_date.date_fiscal_year_txt) derived_table1
  GROUP BY derived_table1.report_date_time, derived_table1.assigned_clerk_key, derived_table1.repeat_customer_key, derived_table1.assigned_channel_key;
--DROP VIEW edh.v_cd100_portsales_sp_biweekly;
CREATE OR REPLACE VIEW edh.v_cd100_portsales_sp_biweekly AS
 SELECT 'now'::text::timestamp with time zone::timestamp without time zone AS report_date_time, cust.asnd_clerk_dstnct_clerk_key AS assigned_clerk_key, clerk.cg1_clerk_key AS clerk_key, clerk.sale_clerk_employee_nbr AS employee_number, cust.cust1_assigned_employee_cd AS assigned_employee_code, shf.customer_key, cust.cust1_client_type_dscr AS client_type_description, period.period_yyyymm AS sum_period_yyyymm, period.month_half AS sum_period_month_half, per_end_dt_key.date_key AS end_of_period_date_key, sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt) AS sum_ext_price_lc_taxincl, 
        CASE
            WHEN COALESCE(
            CASE
                WHEN ltrim(clerk.sale_clerk_employee_nbr::text, 0::text) = ''::text THEN NULL::text
                ELSE ltrim(clerk.sale_clerk_employee_nbr::text, 0::text)
            END, 'NULL_EMPL_NBR'::text) = COALESCE(
            CASE
                WHEN ltrim(cust.cust1_assigned_employee_cd::text, 0::text) = ''::text THEN NULL::text
                ELSE ltrim(cust.cust1_assigned_employee_cd::text, 0::text)
            END, 'NULL_ASGN_EMPL_CD'::text) THEN 1
            ELSE 0
        END AS mysale_flag, sum(
        CASE
            WHEN (shf.extended_price_local_currency_amt + shf.tax_local_currency_amt) < 0::numeric THEN -1
            ELSE 1
        END) AS net_transactions
   FROM edh.sales_history_fact shf
   LEFT JOIN ( SELECT cust1.customer_key AS cust1_customer_key, cust1.assigned_employee_cd AS cust1_assigned_employee_cd, cust1.client_type_dscr AS cust1_client_type_dscr, asnd_clerk_dstnct.clerk_key AS asnd_clerk_dstnct_clerk_key, asnd_clerk_dstnct.source_clerk_key AS asnd_clerk_dstnct_source_clerk_id, asnd_clerk_dstnct.clerk_id AS asnd_clerk_dstnct_clerk_id, asnd_clerk_dstnct.employee_nbr AS asnd_clerk_dstnct_employee_nbr, cust1.employee_ind AS cust1_employee_ind
           FROM edh.customer_dim cust1
      LEFT JOIN edh.v_cd100_clerk_dim_distinct asnd_clerk_dstnct ON ltrim(cust1.assigned_employee_cd::text, 0::text) = ltrim(asnd_clerk_dstnct.employee_nbr::text, 0::text)) cust ON shf.customer_key = cust.cust1_customer_key
   LEFT JOIN ( SELECT cg1.source_clerk_group_key AS cg1_source_clerk_group_key, cg1.clerk_key AS cg1_clerk_key, cg1.clerk_sequence_nbr AS cg1_clerk_sequence_nbr, sale_clerk.clerk_key AS sale_clerk_clerk_key, sale_clerk.source_clerk_key AS sale_clerk_source_clerk_key, sale_clerk.clerk_id AS sale_clerk_clerk_id, sale_clerk.employee_nbr AS sale_clerk_employee_nbr
      FROM edh.clerk_group_dim cg1
   JOIN edh.clerk_dim sale_clerk ON cg1.clerk_key = sale_clerk.clerk_key) clerk ON shf.clerk_group_key = clerk.cg1_source_clerk_group_key
   LEFT JOIN edh.date_dim sale_date ON shf.invoice_date_key = sale_date.date_key
   LEFT JOIN edh.product_dim prdct ON shf.product_key = prdct.product_key
   LEFT JOIN edh.channel_dim chnl ON shf.channel_key = chnl.channel_key
   JOIN ( SELECT "max"(d.date_dt) AS period_end_date_dt, "substring"(d.date_cymd_nbr::text, 1, 6) AS period_yyyymm, 
        CASE
            WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
            ELSE 2
        END AS month_half
   FROM edh.date_dim d
  WHERE d.date_dd_nbr <> 0
  GROUP BY "substring"(d.date_cymd_nbr::text, 1, 6), 
        CASE
            WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
            ELSE 2
        END) period ON "substring"(sale_date.date_cymd_nbr::text, 1, 6) = period.period_yyyymm AND 
CASE
WHEN "substring"(sale_date.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
ELSE 2
END = period.month_half
   JOIN edh.date_dim per_end_dt_key ON per_end_dt_key.date_dt = period.period_end_date_dt
  WHERE prdct.sku_nbr > 10000000 AND prdct.department_nbr <> 401 AND prdct.department_nbr <> 409 AND prdct.department_nbr <> 410 AND prdct.financial_product_family_nm::text <> 'EMPLOYEE STORE'::text AND chnl.channel_nm::text <> 'Wholesale'::text AND chnl.channel_nm::text <> 'Corporate'::text AND chnl.business_group_nm::text = 'Tiffany'::text AND (sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = (( SELECT 'now'::character varying::date AS date))))::text) OR sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) OR sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = date_add('year'::text, -2::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text)) AND period.period_end_date_dt < 'now'::character varying::date AND chnl.sub_channel_nm::text <> 'Direct TFB'::text AND chnl.sub_channel_nm::text <> 'E-TFB'::text AND chnl.sub_channel_nm::text <> 'Retail TFB'::text AND (cust.cust1_client_type_dscr::text = 'Portfolio'::text OR cust.cust1_client_type_dscr::text = 'Portfolio Bridal'::text) AND cust.cust1_assigned_employee_cd IS NOT NULL AND clerk.cg1_clerk_sequence_nbr = 1 AND cust.cust1_employee_ind <> 1
  GROUP BY cust.asnd_clerk_dstnct_clerk_key, clerk.cg1_clerk_key, clerk.sale_clerk_employee_nbr, cust.cust1_assigned_employee_cd, shf.customer_key, cust.cust1_client_type_dscr, period.period_yyyymm, period.month_half, per_end_dt_key.date_key;
--DROP VIEW edh.v_cd100_portsales_store_biweekly;
CREATE OR REPLACE VIEW edh.v_cd100_portsales_store_biweekly AS
 SELECT 'now'::text::timestamp with time zone::timestamp without time zone AS report_date_time, chnl.channel_key, clerk.clerk_key, clerk.employee_nbr AS employee_number, shf.customer_key, period.period_yyyymm || period.month_half::text AS period_cd, per_end_dt_key.date_key AS end_of_period_date_key, sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt) AS sum_ext_price_lc_taxincl, sum(shf.extended_price_usd_amt + shf.tax_usd_amt) AS sum_ext_price_usd_taxincl, 
        CASE
            WHEN chnl.channel_key = shf.channel_key THEN 1
            ELSE 0
        END AS instore_sale_ind, shf.channel_key AS selling_channel_key, sum(
        CASE
            WHEN (shf.extended_price_local_currency_amt + shf.tax_local_currency_amt) < 0::numeric THEN -1
            ELSE 1
        END) AS net_transactions
   FROM edh.sales_history_fact shf
   LEFT JOIN edh.customer_dim cust ON shf.customer_key = cust.customer_key
   LEFT JOIN edh.v_cd100_clerk_dim_distinct clerk ON ltrim(cust.assigned_employee_cd::text, '0'::text) = ltrim(clerk.employee_nbr::text, '0'::text)
   LEFT JOIN edh.date_dim sale_date ON shf.invoice_date_key = sale_date.date_key
   LEFT JOIN edh.product_dim prdct ON shf.product_key = prdct.product_key
   LEFT JOIN edh.cd100_ref_chnl_key_lkp_tmp chnl_lu ON chnl_lu.financial_location::text = clerk.store_nbr::text AND chnl_lu.channel::text = 'IV'::text
   LEFT JOIN edh.channel_dim chnl ON chnl_lu.channel_dim_channel_key::text = chnl.channel_key::text
   JOIN ( SELECT "max"(d.date_dt) AS period_end_date_dt, "substring"(d.date_cymd_nbr::text, 1, 6) AS period_yyyymm, 
        CASE
            WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
            ELSE 2
        END AS month_half
   FROM edh.date_dim d
  WHERE d.date_dd_nbr <> 0
  GROUP BY "substring"(d.date_cymd_nbr::text, 1, 6), 
        CASE
            WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
            ELSE 2
        END) period ON "substring"(sale_date.date_cymd_nbr::text, 1, 6) = period.period_yyyymm AND 
CASE
WHEN "substring"(sale_date.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
ELSE 2
END = period.month_half
   JOIN edh.date_dim per_end_dt_key ON per_end_dt_key.date_dt = period.period_end_date_dt
  WHERE prdct.sku_nbr > 10000000 AND prdct.department_nbr <> 401 AND prdct.department_nbr <> 409 AND prdct.department_nbr <> 410 AND prdct.financial_product_family_nm::text <> 'EMPLOYEE STORE'::text AND chnl.channel_nm::text <> 'Wholesale'::text AND chnl.channel_nm::text <> 'Corporate'::text AND chnl.business_group_nm::text = 'Tiffany'::text AND (sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = (( SELECT 'now'::character varying::date AS date))))::text) OR sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) OR sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = date_add('year'::text, -2::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text)) AND period.period_end_date_dt < 'now'::character varying::date AND chnl.sub_channel_nm::text <> 'Direct TFB'::text AND chnl.sub_channel_nm::text <> 'E-TFB'::text AND chnl.sub_channel_nm::text <> 'Retail TFB'::text AND (cust.client_type_dscr::text = 'Portfolio'::text OR cust.client_type_dscr::text = 'Portfolio Bridal'::text) AND cust.employee_ind <> 1
  GROUP BY chnl.channel_key, clerk.clerk_key, clerk.employee_nbr, shf.customer_key, shf.channel_key, period.period_yyyymm || period.month_half::text, per_end_dt_key.date_key, clerk.store_nbr, chnl.mips_store_nbr;
--DROP VIEW edh.v_cd100_regcust_sales;
CREATE OR REPLACE VIEW edh.v_cd100_regcust_sales AS
 SELECT derived_table1.report_date_time, derived_table1.purchaser_customer_key, derived_table1.selling_channel_key, derived_table1.selling_clerk_key, derived_table1.customer_tourist_type, 
        CASE
            WHEN sum(derived_table1.ppy_total_sales) > 0::numeric THEN 1
            ELSE 0
        END AS ppy_purchase_flag, 
        CASE
            WHEN sum(derived_table1.py_total_sales) > 0::numeric THEN 1
            ELSE 0
        END AS py_purchase_flag, 
        CASE
            WHEN sum(derived_table1.pytd_total_sales) > 0::numeric THEN 1
            ELSE 0
        END AS pytd_purchase_flag, 
        CASE
            WHEN sum(derived_table1.fytd_total_sales) > 0::numeric THEN 1
            ELSE 0
        END AS fytd_purchase_flag, sum(derived_table1.ppy_total_sales) AS ppy_total_sales, sum(derived_table1.py_total_sales) AS py_total_sales, sum(derived_table1.pytd_total_sales) AS pytd_total_sales, sum(derived_table1.fytd_total_sales) AS fytd_total_sales, ( SELECT date_dim.date_key
           FROM edh.date_dim
          WHERE date_dim.date_dt = (( SELECT "max"(a.period_end_date) AS last_pd_end_date
                   FROM ( SELECT "max"(d.date_dt) AS period_end_date, "substring"(d.date_cymd_nbr::text, 1, 6) AS period_yyyymm, 
                                CASE
                                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                                    ELSE 2
                                END AS month_half
                           FROM edh.date_dim d
                          WHERE d.date_dd_nbr <> 0
                          GROUP BY "substring"(d.date_cymd_nbr::text, 1, 6), 
                                CASE
                                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                                    ELSE 2
                                END) a
                  WHERE a.period_end_date < (( SELECT 'now'::character varying::date AS date))))) AS end_of_period_date_key, sum(derived_table1.net_transactions) AS net_transactions
   FROM ( SELECT 'now'::text::timestamp with time zone::timestamp without time zone AS report_date_time, cust.customer_key AS purchaser_customer_key, shf.channel_key AS selling_channel_key, cg.clerk_key AS selling_clerk_key, 
                CASE
                    WHEN cust.display_country_nm::text = cl.country_display_nm::text OR cust.assigned_employee_cd IS NULL AND cust.display_country_nm::text = chnl1.display_country_nm::text OR (cust.display_country_nm::text = ''::text OR cust.display_country_nm IS NULL) AND (tourism.tourism_type::text = 'Local'::text OR tourism.tourism_type::text = 'Domestic'::text OR tourism.tourism_type::text = 'Unknown'::text OR tourism.tourism_type::text = ''::text OR tourism.tourism_type::text = 'NULL'::text) THEN 'Local'::text
                    WHEN cust.assigned_employee_cd IS NOT NULL AND COALESCE(cl.country_display_nm, ''::character varying)::text = ''::text THEN NULL::text
                    ELSE 'Tourist'::text
                END AS customer_tourist_type, sale_date.date_fiscal_year_txt AS fy_txt, sale_date.date_dt, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) THEN sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt)
                    ELSE 0::numeric
                END AS py_total_sales, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = date_add('year'::text, -2::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) THEN sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt)
                    ELSE 0::numeric
                END AS ppy_total_sales, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) AND sale_date.date_dt <= (( SELECT "max"(a.period_end_date) AS "max"
                       FROM ( SELECT "max"(d.date_dt) AS period_end_date, "substring"(d.date_cymd_nbr::text, 1, 6) AS period_yyyymm, 
                                    CASE
                                        WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                                        ELSE 2
                                    END AS month_half
                               FROM edh.date_dim d
                              WHERE d.date_dd_nbr <> 0
                              GROUP BY "substring"(d.date_cymd_nbr::text, 1, 6), 
                                    CASE
                                        WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                                        ELSE 2
                                    END) a
                      WHERE a.period_end_date < date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone))) THEN sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt)
                    ELSE 0::numeric
                END AS pytd_total_sales, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = (( SELECT 'now'::character varying::date AS date))))::text) THEN sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt)
                    ELSE 0::numeric
                END AS fytd_total_sales, sum(
                CASE
                    WHEN (shf.extended_price_local_currency_amt + shf.tax_local_currency_amt) < 0::numeric THEN -1
                    ELSE 1
                END) AS net_transactions
           FROM edh.customer_dim cust
      LEFT JOIN edh.sales_history_fact shf ON cust.customer_key = shf.customer_key
   LEFT JOIN edh.v_cd100_clerk_dim_distinct cl ON ltrim(cust.assigned_employee_cd::text, '0'::character varying::text) = ltrim(cl.employee_nbr::text, '0'::character varying::text)
   JOIN edh.date_dim sale_date ON shf.invoice_date_key = sale_date.date_key
   LEFT JOIN edh.channel_dim chnl1 ON shf.channel_key = chnl1.channel_key
   LEFT JOIN edh.product_dim prdct ON shf.product_key::character varying::text = prdct.product_key::character varying::text
   LEFT JOIN edh.clerk_group_dim cg ON cg.source_clerk_group_key = shf.clerk_group_key AND cg.clerk_sequence_nbr = 1
   LEFT JOIN edh.tourism_dim tourism ON tourism.tourism_key = shf.tourism_key
  WHERE chnl1.channel_nm::text = 'Retail'::text AND cust.ecm_customer_id > 0 AND cust.ecm_customer_id IS NOT NULL AND cust.crm_system_id = 1 AND cust.customer_first_nm IS NOT NULL AND cust.customer_last_nm IS NOT NULL AND (cust.address_line_1_txt IS NOT NULL OR cust.address_line_2_txt IS NOT NULL OR cust.address_line_3_txt IS NOT NULL OR cust.address_line_4_txt IS NOT NULL OR cust.phone_nbr IS NOT NULL OR cust.phone_nbr::text <> ''::text OR cust.customer_email_txt::text ~~ '%＠%'::text OR cust.customer_email_txt::text ~~ '%@%'::text) AND chnl1.business_group_nm::text = 'Tiffany'::text AND shf.department_nbr <> 401 AND shf.department_nbr <> 409 AND shf.department_nbr <> 410 AND prdct.sku_nbr > 10000000 AND prdct.financial_product_family_nm::text <> 'EMPLOYEE STORE'::text AND shf.number_of_units_qty <> 0 AND (sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = (( SELECT 'now'::character varying::date AS date))))::text) OR sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = date_add('year'::character varying::text, - 1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) OR sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = date_add('year'::character varying::text, - 2::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text)) AND chnl1.sub_channel_nm::text <> 'Direct TFB'::text AND chnl1.sub_channel_nm::text <> 'E-TFB'::text AND chnl1.sub_channel_nm::text <> 'Retail TFB'::text AND cust.employee_ind <> 1 AND sale_date.date_dt <= (( SELECT "max"(a.period_end_date) AS last_pd_end_date
   FROM ( SELECT "max"(d.date_dt) AS period_end_date, "substring"(d.date_cymd_nbr::text, 1, 6) AS period_yyyymm, 
                CASE
                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                    ELSE 2
                END AS month_half
           FROM edh.date_dim d
          WHERE d.date_dd_nbr <> 0
          GROUP BY "substring"(d.date_cymd_nbr::text, 1, 6), 
                CASE
                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                    ELSE 2
                END) a
  WHERE a.period_end_date < (( SELECT 'now'::character varying::date AS date))))
  GROUP BY cust.customer_key, shf.channel_key, cg.clerk_key, cust.display_country_nm, cl.country_display_nm, cust.assigned_employee_cd, chnl1.display_country_nm, tourism.tourism_type, sale_date.date_fiscal_year_txt, shf.invoice_date_key, sale_date.date_dt) derived_table1
  GROUP BY derived_table1.report_date_time, derived_table1.purchaser_customer_key, derived_table1.selling_channel_key, derived_table1.selling_clerk_key, derived_table1.customer_tourist_type;
--DROP VIEW edh.v_cd100_total_transactions;
CREATE OR REPLACE VIEW edh.v_cd100_total_transactions AS
 SELECT derived_table1.report_date_time, derived_table1.customer_key, derived_table1.selling_channel_key, derived_table1.selling_clerk_key, sum(derived_table1.ppy_total_transactions_sales) AS ppy_total_transaction_sales, sum(derived_table1.py_total_transactions_sales) AS py_total_transaction_sales, sum(derived_table1.pytd_total_transactions_sales) AS pytd_total_transaction_sales, sum(derived_table1.fytd_total_transactions_sales) AS fytd_total_transaction_sales, ( SELECT date_dim.date_key
           FROM edh.date_dim
          WHERE date_dim.date_dt = (( SELECT "max"(a.period_end_date) AS last_pd_end_date
                   FROM ( SELECT "max"(d.date_dt) AS period_end_date, "substring"(d.date_cymd_nbr::text, 1, 6) AS period_yyyymm, 
                                CASE
                                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                                    ELSE 2
                                END AS month_half
                           FROM edh.date_dim d
                          WHERE d.date_dd_nbr <> 0
                          GROUP BY "substring"(d.date_cymd_nbr::text, 1, 6), 
                                CASE
                                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                                    ELSE 2
                                END) a
                  WHERE a.period_end_date < (( SELECT 'now'::character varying::date AS date))))) AS end_of_period_date_key
   FROM ( SELECT 'now'::text::timestamp with time zone::timestamp without time zone AS report_date_time, cust.customer_key, shf.channel_key AS selling_channel_key, cg.clerk_key AS selling_clerk_key, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) THEN sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt)
                    ELSE 0::numeric
                END AS py_total_transactions_sales, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = date_add('year'::text, -2::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) THEN sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt)
                    ELSE 0::numeric
                END AS ppy_total_transactions_sales, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) AND sale_date.date_dt <= (( SELECT "max"(a.period_end_date) AS "max"
                       FROM ( SELECT "max"(d.date_dt) AS period_end_date, "substring"(d.date_cymd_nbr::text, 1, 6) AS period_yyyymm, 
                                    CASE
                                        WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                                        ELSE 2
                                    END AS month_half
                               FROM edh.date_dim d
                              WHERE d.date_dd_nbr <> 0
                              GROUP BY "substring"(d.date_cymd_nbr::text, 1, 6), 
                                    CASE
                                        WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                                        ELSE 2
                                    END) a
                      WHERE a.period_end_date < date_add('year'::text, -1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone))) THEN sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt)
                    ELSE 0::numeric
                END AS pytd_total_transactions_sales, 
                CASE
                    WHEN sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
                       FROM edh.date_dim d
                      WHERE d.date_dt = (( SELECT 'now'::character varying::date AS date))))::text) THEN sum(shf.extended_price_local_currency_amt + shf.tax_local_currency_amt)
                    ELSE 0::numeric
                END AS fytd_total_transactions_sales
           FROM edh.customer_dim cust
      LEFT JOIN edh.sales_history_fact shf ON cust.customer_key = shf.customer_key
   LEFT JOIN edh.v_cd100_clerk_dim_distinct cl ON ltrim(cust.assigned_employee_cd::text, '0'::character varying::text) = ltrim(cl.employee_nbr::text, '0'::character varying::text)
   JOIN edh.date_dim sale_date ON shf.invoice_date_key = sale_date.date_key
   LEFT JOIN edh.channel_dim chnl1 ON shf.channel_key = chnl1.channel_key
   LEFT JOIN edh.product_dim prdct ON shf.product_key::character varying::text = prdct.product_key::character varying::text
   LEFT JOIN edh.clerk_group_dim cg ON cg.source_clerk_group_key = shf.clerk_group_key AND cg.clerk_sequence_nbr = 1
  WHERE chnl1.channel_nm::text <> 'Wholesale'::text AND chnl1.channel_nm::text <> 'Corporate'::text AND chnl1.business_group_nm::text = 'Tiffany'::text AND cust.crm_system_id = 1 AND prdct.financial_product_family_nm::text <> 'EMPLOYEE STORE'::text AND (sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = (( SELECT 'now'::character varying::date AS date))))::text) OR sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = date_add('year'::character varying::text, - 1::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text) OR sale_date.date_fiscal_year_txt::text = ((( SELECT d.date_fiscal_year_txt
   FROM edh.date_dim d
  WHERE d.date_dt = date_add('year'::character varying::text, - 2::bigint, (( SELECT 'now'::character varying::date AS date))::timestamp without time zone)))::text)) AND chnl1.sub_channel_nm::text <> 'Direct TFB'::text AND chnl1.sub_channel_nm::text <> 'E-TFB'::text AND chnl1.sub_channel_nm::text <> 'Retail TFB'::text AND cust.employee_ind <> 1 AND sale_date.date_dt <= (( SELECT "max"(a.period_end_date) AS last_pd_end_date
   FROM ( SELECT "max"(d.date_dt) AS period_end_date, "substring"(d.date_cymd_nbr::text, 1, 6) AS period_yyyymm, 
                CASE
                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                    ELSE 2
                END AS month_half
           FROM edh.date_dim d
          WHERE d.date_dd_nbr <> 0
          GROUP BY "substring"(d.date_cymd_nbr::text, 1, 6), 
                CASE
                    WHEN "substring"(d.date_cymd_nbr::text, 7, 2) < 16::text THEN 1
                    ELSE 2
                END) a
  WHERE a.period_end_date < (( SELECT 'now'::character varying::date AS date)))) AND shf.number_of_units_qty <> 0
  GROUP BY cust.customer_key, shf.channel_key, cg.clerk_key, sale_date.date_fiscal_year_txt, shf.invoice_date_key, sale_date.date_dt) derived_table1
  GROUP BY derived_table1.report_date_time, derived_table1.customer_key, derived_table1.selling_channel_key, derived_table1.selling_clerk_key;
--DROP VIEW edh.v_lookup_ecpclrk;
CREATE OR REPLACE VIEW edh.v_lookup_ecpclrk AS
 SELECT emp.employeeno AS employee_no, emp.clerkid AS clerk_id, emp.storeno AS store_number, emp.datelastmodified AS last_update
   FROM ( SELECT pg_catalog.row_number()
          OVER( 
          PARTITION BY sae.employeeno
          ORDER BY sae.datelastmodified DESC, sae.applicationid) AS row_number, sae.employeeno, sae.clerkid, sae.storeno::integer AS storeno, sae.datelastmodified
           FROM edh.stg_auth_employee sae
          WHERE sae.employeeno IS NOT NULL AND COALESCE(sae.clerkid, 0::bigint) > 0 AND COALESCE(sae.storeno, ''::character varying)::text <> ''::text AND sae.isactive = 1) emp;
--DROP VIEW edh.epd_view_tableau;
CREATE OR REPLACE VIEW edh.epd_view_tableau AS
 SELECT delivery_response_aggr.delivery_response_aggr_id, delivery_response_aggr.source_type, delivery_response_aggr.source_nm, delivery_response_aggr.metric_type, delivery_response_aggr.source_operation_id, delivery_response_aggr.source_delivery_id, delivery_response_aggr.delivery_segment_cd, delivery_response_aggr.ip_affinity_cd, delivery_response_aggr.mb_primary_segment_cd, delivery_response_aggr.email_domain_nm, delivery_response_aggr.days_between_delivery_and_first_conversion_qty, delivery_response_aggr.total_sent_cnt, delivery_response_aggr.total_hard_bounce_cnt, delivery_response_aggr.total_soft_bounce_cnt, delivery_response_aggr.total_complaint_cnt, delivery_response_aggr.total_delivered_cnt, delivery_response_aggr.total_open_cnt, delivery_response_aggr.total_click_cnt, delivery_response_aggr.total_opt_out_cnt, delivery_response_aggr.total_unique_open_cnt, delivery_response_aggr.total_unique_click_cnt, delivery_response_aggr.total_unique_opt_out_cnt, delivery_response_aggr.total_orders_cnt, delivery_response_aggr.total_units_cnt, delivery_response_aggr.total_revenue_in_local_currency_amt, delivery_response_aggr.total_revenue_in_usd_amt, delivery_response_aggr.source_channel_key, delivery_response_aggr.source_product_key, delivery_response_aggr.attribution_type, delivery_response_aggr.total_direct_attribution_orders_cnt, delivery_response_aggr.total_direct_attribution_units_cnt, delivery_response_aggr.total_direct_attribution_revenue_in_local_currency_amt, delivery_response_aggr.total_direct_attribution_revenue_in_usd_amt, delivery_response_aggr.total_inferred_attribution_orders_cnt, delivery_response_aggr.total_inferred_attribution_units_cnt, delivery_response_aggr.total_inferred_attribution_revenue_in_local_currency_amt, delivery_response_aggr.total_inferred_attribution_revenue_in_usd_amt, delivery_response_aggr.mbv_primary_segment_cd, delivery_response_aggr.mbv_primary_segment_dscr, delivery_response_aggr.delivery_source_delivery_id, delivery_response_aggr.delivery_source_operation_id, delivery_response_aggr.delivery_label_txt, delivery_response_aggr.delivery_message_type_cd, delivery_response_aggr.delivery_broad_start_tmstmp, delivery_response_aggr.delivery_tracked_from_date_key, delivery_response_aggr.delivery_tracked_to_date_key, delivery_response_aggr.delivery_is_report_ind, delivery_response_aggr.delivery_cd, delivery_response_aggr.delivery_country_cd, delivery_response_aggr.delivery_promotion_period_nm, delivery_response_aggr.delivery_creative_format_nm, delivery_response_aggr.delivery_creative_version_nm, delivery_response_aggr.delivery_iso_2_char_country_cd, delivery_response_aggr.delivery_local_currency_cd, delivery_response_aggr.delivery_has_control_ind, delivery_response_aggr.delivery_has_treated_ind, delivery_response_aggr.delivery_inferred_thru_date_key, delivery_response_aggr.market_iso_2_char_country_cd, delivery_response_aggr.market_iso_3_char_country_cd, delivery_response_aggr.market_iso_numeric_country_cd, delivery_response_aggr.market_iso_3_cd, delivery_response_aggr.market_english_label_txt, delivery_response_aggr.market_local_currency_cd, delivery_response_aggr.market_region_nm, delivery_response_aggr.operation_source_operation_id, delivery_response_aggr.operation_message_type_cd, delivery_response_aggr.operation_label_txt, delivery_response_aggr.operation_nature_nm, delivery_response_aggr.operation_control_end_date_key, delivery_response_aggr.date_date_key, delivery_response_aggr.date_date_tmstmp, delivery_response_aggr.date_date_dt, delivery_response_aggr.epd_currency_cd, delivery_response_aggr.epd_currency_nm, delivery_response_aggr.epd_currency_symbol, delivery_response_aggr.epd_unidec01_nbr, delivery_response_aggr.epd_unidec02_nbr, delivery_response_aggr.epd_unidec03_nbr, delivery_response_aggr.epd_unidec04_nbr, delivery_response_aggr.epd_unihex01_nbr, delivery_response_aggr.epd_unihex02_nbr, delivery_response_aggr.epd_unihex03_nbr, delivery_response_aggr.epd_unihex04_nbr, delivery_response_aggr.ipaffinity_ip_affinity_cd, delivery_response_aggr.ipaffinity_ip_affinity_dscr, delivery_response_aggr.channel_source_channel_key, delivery_response_aggr.channel_display_country_nm, delivery_response_aggr.channel_currency_cd, delivery_response_aggr.channel_business_type, delivery_response_aggr.channel_unified_channel_nm, delivery_response_aggr.channel_sub_channel_nm, delivery_response_aggr.channel_include_channel_ind, delivery_response_aggr.channel_retail_channel_ind, delivery_response_aggr.product_source_product_key, delivery_response_aggr.product_financial_product_family_nm, delivery_response_aggr.product_financial_product_sub_family_nm, delivery_response_aggr.product_epd_revised_merchandise_collection_nm, delivery_response_aggr.product_epd_product_type_tier_2_nm, delivery_response_aggr.product_class_dscr, delivery_response_aggr.product_department_dscr, delivery_response_aggr.product_include_units_ind, delivery_response_aggr.deliverysegment_delivery_id, delivery_response_aggr.deliverysegment_segment_cd, delivery_response_aggr.deliverysegment_control_ind, delivery_response_aggr.deliverysegment_treated_ind, delivery_response_aggr.script_nm, delivery_response_aggr.create_tmstmp, delivery_response_aggr.update_tmstmp
   FROM edh.delivery_response_aggr;
--DROP VIEW edh.v_stg_clienteling_action_opportunity_fact;
--EDM-1431 - A&O Create SP is the same as the Assigned To SP - Update logic for creator clerk
--EDM-1720 - A&O update filter/logic to select flagship data 
CREATE OR REPLACE VIEW edh.v_stg_clienteling_action_opportunity_fact
(
  source_action_opportunity_key,
  clienteling_act_opp_attribute_key,
  creator_clerk_key,
  assigned_to_clerk_key,
  assigned_clerk_key,
  associated_channel_key,
  customer_key,
  gift_product_sku,
  gift_country_id,
  gift_retail_value_local_currency_amount,
  gift_description,
  source_country_id,
  created_date_key,
  due_date_key,
  completed_date_key,
  modified_date_key,
  consultation_date_key,
  associated_store_nbr,
  created_by_id,
  modified_by_id,
  reviewed_by_id,
  row_type,
  create_tmstmp,
  update_tmstmp,
  load_script_nm,
  stg_mapping_nm,
  stg_workflow_instance_id
)
AS 
 SELECT DISTINCT non_flagship.source_action_opportunity_key, non_flagship.clienteling_act_opp_attribute_key, non_flagship.creator_clerk_key, non_flagship.assigned_to_clerk_key, non_flagship.assigned_clerk_key, 
        CASE
            WHEN non_flagship.associated_channel_key IS NULL THEN flagship.associated_channel_key
            ELSE non_flagship.associated_channel_key
        END AS associated_channel_key, non_flagship.customer_key, non_flagship.gift_product_sku, non_flagship.gift_country_id, non_flagship.gift_retail_value_local_currency_amount, non_flagship.gift_description, non_flagship.source_country_id, non_flagship.created_date_key, non_flagship.due_date_key, non_flagship.completed_date_key, non_flagship.modified_date_key, non_flagship.consultation_date_key, non_flagship.associated_store_nbr, non_flagship.created_by_id, non_flagship.modified_by_id, non_flagship.reviewed_by_id, non_flagship.row_type, non_flagship.create_tmstmp, non_flagship.update_tmstmp, non_flagship.load_script_nm, non_flagship.stg_mapping_nm, non_flagship.stg_workflow_instance_id
   FROM ( SELECT act.actionitemid AS source_action_opportunity_key, actopp.clienteling_act_opp_attribute_key, creatorclerk.clerk_key AS creator_clerk_key, clerk.clerk_key AS assigned_to_clerk_key, asnd.clerk_key AS assigned_clerk_key, chnl.channel_key AS associated_channel_key, cust.customer_key, act.giftsku AS gift_product_sku, countrygift.country_id AS gift_country_id, act.giftretailvalue AS gift_retail_value_local_currency_amount, act.giftdescription AS gift_description, countrysource.country_id AS source_country_id, createddt.date_key AS created_date_key, duedt.date_key AS due_date_key, completeddt.date_key AS completed_date_key, modifieddt.date_key AS modified_date_key, consultationdt.date_key AS consultation_date_key, act.associatedstorenumber AS associated_store_nbr, act.createdby AS created_by_id, act.modifiedby AS modified_by_id, act.reviewedby AS reviewed_by_id, act.rcd_actn_ind AS row_type, 'now'::character varying::timestamp without time zone AS create_tmstmp, 'now'::character varying::timestamp without time zone AS update_tmstmp, 'load_stg_clienteling_action_opportunity_fact.sql'::character varying AS load_script_nm, act.stg_load_mapping_nm AS stg_mapping_nm, act.stg_load_instance_id AS stg_workflow_instance_id
           FROM edh.stg_usr_actionitems act
      LEFT JOIN edh.customer_dim cust ON cust.ecm_customer_id = act.customerid AND cust.crm_system_id = 1
   LEFT JOIN edh.country_master countrygift ON act.giftcountycode::text = countrygift.country_iso_2_char_cd::text
   LEFT JOIN edh.country_master countrysource ON act.sourcecountryid = countrysource.country_id
   LEFT JOIN edh.v_cd100_clerk_dim_distinct clerk ON act.assignedemployeenumber::character varying::text = clerk.employee_nbr::text
   LEFT JOIN edh.v_cd100_clerk_dim_distinct asnd ON ltrim(cust.assigned_employee_cd::text, 0::character varying::text) = ltrim(asnd.employee_nbr::text, 0::character varying::text)
   LEFT JOIN edh.v_cd100_clerk_dim_distinct creatorclerk ON act.createdemployeenumber::character varying::text = creatorclerk.employee_nbr::text
   LEFT JOIN edh.date_dim createddt ON createddt.date_dt = act.datecreated::date
   LEFT JOIN edh.date_dim duedt ON duedt.date_dt = act.duedatetime::date
   LEFT JOIN edh.date_dim completeddt ON completeddt.date_dt = act.datecompleted::date
   LEFT JOIN edh.date_dim modifieddt ON modifieddt.date_dt = act.datelastmodified::date
   LEFT JOIN edh.date_dim consultationdt ON consultationdt.date_dt = act.consultationdatetime::date
   LEFT JOIN edh.cd100_ref_chnl_key_lkp_tmp chnl_lu ON chnl_lu.financial_location::text = act.associatedstorenumber::character varying::text AND chnl_lu.channel::text = 'IV'::character varying::text AND chnl_lu.financial_location::text <> 1::character varying::text
   LEFT JOIN edh.channel_dim chnl ON chnl_lu.channel_dim_channel_key::text = chnl.channel_key::character varying::text
   LEFT JOIN edh.clienteling_action_opportunity_attr_dim actopp ON COALESCE(actopp.action_item_type_cd, - 1::bigint) = COALESCE(act.actionitemtypeid, - 1::bigint) AND COALESCE(actopp.action_priority_type_cd, - 1::bigint) = COALESCE(act.actionprioritytypeid, - 1::bigint) AND COALESCE(actopp.outreach_action_reason_type_cd, - 1::bigint) = COALESCE(act.outreachactionreasontypeid, - 1::bigint) AND COALESCE(actopp.outreach_action_method_type_cd, - 1::bigint) = COALESCE(act.outreachactionmethodtypeid, - 1::bigint) AND COALESCE(actopp.action_initiative_type_cd, - 1::bigint) = COALESCE(act.actioninitiativetypeid, - 1::bigint) AND COALESCE(actopp.action_status_type_cd, - 1::bigint) = COALESCE(act.actionstatustypeid, - 1::bigint) AND COALESCE(actopp.action_gift_type_cd, - 1::bigint) = COALESCE(act.actiongifttypeid, - 1::bigint)) non_flagship
   JOIN ( SELECT act.actionitemid AS source_action_opportunity_key, actopp.clienteling_act_opp_attribute_key, creatorclerk.clerk_key AS creator_clerk_key, clerk.clerk_key AS assigned_to_clerk_key, asnd.clerk_key AS assigned_clerk_key, chnl.channel_key AS associated_channel_key, cust.customer_key, act.giftsku AS gift_product_sku, countrygift.country_id AS gift_country_id, act.giftretailvalue AS gift_retail_value_local_currency_amount, act.giftdescription AS gift_description, countrysource.country_id AS source_country_id, createddt.date_key AS created_date_key, duedt.date_key AS due_date_key, completeddt.date_key AS completed_date_key, modifieddt.date_key AS modified_date_key, consultationdt.date_key AS consultation_date_key, act.associatedstorenumber AS associated_store_nbr, act.createdby AS created_by_id, act.modifiedby AS modified_by_id, act.reviewedby AS reviewed_by_id, act.rcd_actn_ind AS row_type, 'now'::character varying::timestamp without time zone AS create_tmstmp, 'now'::character varying::timestamp without time zone AS update_tmstmp, 'load_stg_clienteling_action_opportunity_fact.sql'::character varying AS load_script_nm, act.stg_load_mapping_nm AS stg_mapping_nm, act.stg_load_instance_id AS stg_workflow_instance_id
           FROM edh.stg_usr_actionitems act
      LEFT JOIN edh.customer_dim cust ON cust.ecm_customer_id = act.customerid AND cust.crm_system_id = 1
   LEFT JOIN edh.country_master countrygift ON act.giftcountycode::text = countrygift.country_iso_2_char_cd::text
   LEFT JOIN edh.country_master countrysource ON act.sourcecountryid = countrysource.country_id
   LEFT JOIN edh.v_cd100_clerk_dim_distinct clerk ON act.assignedemployeenumber::character varying::text = clerk.employee_nbr::text
   LEFT JOIN edh.v_cd100_clerk_dim_distinct asnd ON ltrim(cust.assigned_employee_cd::text, 0::character varying::text) = ltrim(asnd.employee_nbr::text, 0::character varying::text)
   LEFT JOIN edh.v_cd100_clerk_dim_distinct creatorclerk ON act.createdemployeenumber::character varying::text = creatorclerk.employee_nbr::text
   LEFT JOIN edh.date_dim createddt ON createddt.date_dt = act.datecreated::date
   LEFT JOIN edh.date_dim duedt ON duedt.date_dt = act.duedatetime::date
   LEFT JOIN edh.date_dim completeddt ON completeddt.date_dt = act.datecompleted::date
   LEFT JOIN edh.date_dim modifieddt ON modifieddt.date_dt = act.datelastmodified::date
   LEFT JOIN edh.date_dim consultationdt ON consultationdt.date_dt = act.consultationdatetime::date
   LEFT JOIN edh.channel_dim chnl ON ltrim(act.associatedstorenumber::character varying::text, 0::character varying::text) = ltrim(chnl.mips_store_nbr::character varying::text, 0::character varying::text) AND chnl.mips_store_nbr = 1 AND chnl.business_type_sort_nbr = 10 AND clerk.location_nm::text = chnl.revenue_center_nm::text
   LEFT JOIN edh.clienteling_action_opportunity_attr_dim actopp ON COALESCE(actopp.action_item_type_cd, - 1::bigint) = COALESCE(act.actionitemtypeid, - 1::bigint) AND COALESCE(actopp.action_priority_type_cd, - 1::bigint) = COALESCE(act.actionprioritytypeid, - 1::bigint) AND COALESCE(actopp.outreach_action_reason_type_cd, - 1::bigint) = COALESCE(act.outreachactionreasontypeid, - 1::bigint) AND COALESCE(actopp.outreach_action_method_type_cd, - 1::bigint) = COALESCE(act.outreachactionmethodtypeid, - 1::bigint) AND COALESCE(actopp.action_initiative_type_cd, - 1::bigint) = COALESCE(act.actioninitiativetypeid, - 1::bigint) AND COALESCE(actopp.action_status_type_cd, - 1::bigint) = COALESCE(act.actionstatustypeid, - 1::bigint) AND COALESCE(actopp.action_gift_type_cd, - 1::bigint) = COALESCE(act.actiongifttypeid, - 1::bigint)) flagship ON non_flagship.source_action_opportunity_key = flagship.source_action_opportunity_key;



GRANT SELECT ON edh.v_stg_clienteling_action_opportunity_fact TO svc_rsbop;
GRANT DELETE, RULE, UPDATE, INSERT, TRIGGER, SELECT, REFERENCES ON edh.v_stg_clienteling_action_opportunity_fact TO service;
GRANT SELECT ON edh.v_stg_clienteling_action_opportunity_fact TO edh_ro;
GRANT TRIGGER, UPDATE, SELECT, REFERENCES, DELETE, RULE, INSERT ON edh.v_stg_clienteling_action_opportunity_fact TO infoadmin;


COMMIT;

--DROP VIEW edh.v_stg_clienteling_employee_task_fact;
CREATE OR REPLACE VIEW edh.v_stg_clienteling_employee_task_fact AS
 SELECT empt.taskid AS source_cl_employee_task_key, cust.customer_key, asnd.clerk_key AS assigned_to_clerk_key, clerk.clerk_key AS receiver_creator_clerk_key, createddt.date_key AS created_date_key, duedt.date_key AS due_date_key, completeddt.date_key AS completed_date_key, reminderdt.date_key AS reminder_date_key, emptaskdim.clienteling_emp_task_attr_key, emaildim.cust_email_contact_task_key, chnl.channel_key, empt.sourcecountryid AS source_country_id, empt.iscomplete AS is_complete_flag, empt.title AS task_title_txt, empt.description AS task_description_txt, empt.storeno AS store_nbr, empt.priority AS priority_nbr, empt.reminderduration AS reminder_duration_nbr, empt.createdby AS created_by_nm, empt.modifiedby AS modified_by_nm, empt.reviewedby AS reviewed_by_nm, empt.rcd_actn_ind AS row_type, 'now'::text::timestamp without time zone AS create_tmstmp, 'now'::text::timestamp without time zone AS update_tmstmp, 'load_stg_clienteling_employee_task_fact.sql' AS load_script_nm, empt.mapping_nm AS stg_mapping_nm, empt.workflow_instance_id AS stg_workflow_instance_id, empt."comment" AS comment_txt
   FROM edh.stg_ecm_emptask empt
   LEFT JOIN edh.customer_dim cust ON empt.customerid = cust.ecm_customer_id AND cust.crm_system_id = 1
   LEFT JOIN edh.v_cd100_clerk_dim_distinct clerk ON empt.employeeno::character varying::text = clerk.employee_nbr::text
   LEFT JOIN edh.v_cd100_clerk_dim_distinct asnd ON ltrim(cust.assigned_employee_cd::text, 0::text) = ltrim(asnd.employee_nbr::text, 0::text)
   LEFT JOIN edh.date_dim createddt ON createddt.date_dt = empt.source_datecreated::date
   LEFT JOIN edh.date_dim duedt ON duedt.date_dt = empt.datedue::date
   LEFT JOIN edh.date_dim completeddt ON completeddt.date_dt = empt.datecompleted::date
   LEFT JOIN edh.date_dim reminderdt ON reminderdt.date_dt = empt.datereminder::date
   LEFT JOIN edh.date_dim modifieddt ON modifieddt.date_dt = empt.source_datelastmodified::date
   LEFT JOIN edh.customer_email_contact_task_dim emaildim ON emaildim.source_task_key = empt.taskid
   LEFT JOIN edh.cd100_ref_chnl_key_lkp_tmp chnl_lu ON chnl_lu.financial_location::text = empt.storeno::text AND chnl_lu.channel::text = 'IV'::text
   LEFT JOIN edh.channel_dim chnl ON chnl_lu.channel_dim_channel_key::text = chnl.channel_key::text
   LEFT JOIN edh.clienteling_emp_task_attr_dim emptaskdim ON COALESCE(emptaskdim.task_type_cd, -1::bigint) = COALESCE(empt.tasktypeid, -1::bigint) AND COALESCE(emptaskdim.customer_contact_reason_cd, -1::bigint)::numeric = COALESCE(empt.customercontactreasoncodeid, -1::numeric) AND COALESCE(emptaskdim.task_outcome_cd, -1::bigint) = COALESCE(empt.taskoutcomeid, -1::bigint) AND COALESCE(emptaskdim.task_initiative_cd, -1::bigint) = COALESCE(empt.taskinitiativetypeid, -1::bigint);