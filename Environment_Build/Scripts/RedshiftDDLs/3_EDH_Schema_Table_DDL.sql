--DROP TABLE "edh"."address_fact";
CREATE TABLE IF NOT EXISTS "edh"."address_fact"
(
	"address_id" BIGINT NOT NULL DEFAULT "identity"(394836, 0, '1,1'::text) ENCODE zstd
	,"source_system_nm" VARCHAR(30)   ENCODE zstd
	,"source_address_id" BIGINT   ENCODE zstd
	,"country_id" BIGINT   ENCODE zstd
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"country_iso_2_char_cd" VARCHAR(2)   ENCODE zstd
	,"country_display_nm" VARCHAR(100)   ENCODE zstd
	,"company_nm" VARCHAR(400)   ENCODE zstd
	,"shipping_instructions_txt" VARCHAR(800)   ENCODE lzo
	,"building_name" VARCHAR(400)   ENCODE zstd
	,"building_1_name" VARCHAR(400)   ENCODE zstd
	,"address_line_1_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_2_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_3_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_4_txt" VARCHAR(400)   ENCODE lzo
	,"city_nm" VARCHAR(280)   ENCODE zstd
	,"city_2_nm" VARCHAR(280)   ENCODE zstd
	,"city_3_nm" VARCHAR(280)   ENCODE lzo
	,"city_4_nm" VARCHAR(280)   ENCODE lzo
	,"alternate_city_nm" VARCHAR(280)   ENCODE zstd
	,"region_nm" VARCHAR(400)   ENCODE zstd
	,"region_2_nm" VARCHAR(400)   ENCODE zstd
	,"postal_cd" VARCHAR(80)   ENCODE zstd
	,"postal_1_cd" VARCHAR(80)   ENCODE zstd
	,"postal_2_cd" VARCHAR(80)   ENCODE zstd
	,"county_nm" VARCHAR(400)   ENCODE zstd
	,"domestic_flg" SMALLINT   ENCODE zstd
	,"active_ind" SMALLINT   ENCODE zstd
	,"active_indicator_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"active_indicator_update_user" VARCHAR(80)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"district_cd" VARCHAR(160)   ENCODE lzo
	,"review_id" VARCHAR(50)   ENCODE lzo
	,"validated_flg" SMALLINT   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (address_id)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"city_nm"
	, "country_display_nm"
	)
;
--DROP TABLE "edh"."audit_customer_address_fact";
CREATE TABLE IF NOT EXISTS "edh"."audit_customer_address_fact"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"create_source_system_key" BIGINT   ENCODE lzo
	,"update_source_system_key" BIGINT   ENCODE lzo
	,"address_id" BIGINT NOT NULL  ENCODE lzo
	,"customer_address_id" BIGINT NOT NULL  ENCODE lzo
	,"address_type_id" BIGINT   
	,"address_type_dscr" VARCHAR(100)   
	,"fraud_type_id" BIGINT   ENCODE lzo
	,"fraud_type_dscr" VARCHAR(50)   ENCODE lzo
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"primary_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"address_type_id"
	, "address_type_dscr"
	)
;
--DROP TABLE "edh"."audit_customer_bio_fact";
CREATE TABLE IF NOT EXISTS "edh"."audit_customer_bio_fact"
(
	"customer_key" BIGINT NOT NULL  ENCODE zstd
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"bio_category_selection_id" BIGINT NOT NULL  ENCODE zstd
	,"bio_category_hierarchy_id" BIGINT   ENCODE zstd
	,"bio_category_parent_type_nm" VARCHAR(160)   ENCODE zstd
	,"bio_category_child_type_nm" VARCHAR(160)   ENCODE zstd
	,"notes_txt" VARCHAR(16000)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE NOT NULL  ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE NOT NULL  ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"bio_category_parent_type_nm"
	, "bio_category_child_type_nm"
	)
;
--DROP TABLE "edh"."audit_customer_comment_fact";
CREATE TABLE IF NOT EXISTS "edh"."audit_customer_comment_fact"
(
	"customer_key" BIGINT NOT NULL  ENCODE zstd
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"comment_id" BIGINT NOT NULL  ENCODE zstd
	,"comment_type_id" BIGINT NOT NULL  ENCODE zstd
	,"comment_type_dscr" VARCHAR(50)   ENCODE zstd
	,"comment_txt" VARCHAR(16000)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"comment_type_id"
	, "comment_type_dscr"
	)
;
--DROP TABLE "edh"."audit_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."audit_customer_dim"
(
	"customer_key" BIGINT NOT NULL  
	,"create_source_system_key" BIGINT   ENCODE lzo
	,"update_source_system_key" BIGINT   ENCODE lzo
	,"original_system_nm" VARCHAR(30)   ENCODE lzo
	,"source_customer_key" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"crm_system_id" BIGINT   ENCODE zstd
	,"customer_nbr" BIGINT   ENCODE zstd
	,"source_system_nm" VARCHAR(20)   ENCODE lzo
	,"source_created_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_last_updt_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"client_type_id" SMALLINT   ENCODE lzo
	,"client_type_dscr" VARCHAR(100)   ENCODE lzo
	,"assigned_employee_cd" VARCHAR(11)   ENCODE lzo
	,"customer_title_txt" VARCHAR(400)   ENCODE lzo
	,"customer_salutation_nm" VARCHAR(400)   ENCODE lzo
	,"customer_first_nm" VARCHAR(200)   ENCODE lzo
	,"customer_middle_nm" VARCHAR(200)   ENCODE lzo
	,"customer_last_nm" VARCHAR(400)   ENCODE lzo
	,"customer_suffix_txt" VARCHAR(320)   ENCODE lzo
	,"customer_full_nm" VARCHAR(400)   ENCODE lzo
	,"customer_post_nm" VARCHAR(400)   ENCODE lzo
	,"employee_ind" SMALLINT   ENCODE lzo
	,"employee_nbr" VARCHAR(11)   ENCODE lzo
	,"gender_nm" VARCHAR(20)   ENCODE lzo
	,"birth_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"customer_marital_status_cd" VARCHAR(1)   ENCODE lzo
	,"customer_marital_status_dscr" VARCHAR(100)   ENCODE lzo
	,"customer_nationality" VARCHAR(50)   ENCODE lzo
	,"first_purchase_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_purchased_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"spend_36_months_amt" NUMERIC(20,5)   ENCODE lzo
	,"spend_lifetime_amt" NUMERIC(20,5)   ENCODE lzo
	,"tr_cd" VARCHAR(4)   ENCODE lzo
	,"tr_dscr" VARCHAR(25)   ENCODE lzo
	,"ecm_active_ind" SMALLINT   ENCODE lzo
	,"cic_flg" CHAR(1)   ENCODE lzo
	,"cic_updt_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"allow_mail_ind" CHAR(1)   ENCODE lzo
	,"allow_email_ind" CHAR(1)   ENCODE lzo
	,"allow_phone_ind" CHAR(1)   ENCODE lzo
	,"allow_txt_ind" CHAR(1)   ENCODE lzo
	,"address_ind" SMALLINT   ENCODE lzo
	,"email_ind" SMALLINT   ENCODE lzo
	,"phone_ind" VARCHAR(25)   ENCODE lzo
	,"household_id" INTEGER   ENCODE lzo
	,"household_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"household_salutation_txt" VARCHAR(800)   ENCODE lzo
	,"household_relationship_type" VARCHAR(25)   ENCODE lzo
	,"household_relationship_driver_ind" VARCHAR(25)   ENCODE lzo
	,"address_line_1_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_2_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_3_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_4_txt" VARCHAR(400)   ENCODE lzo
	,"building_nm" VARCHAR(400)   ENCODE zstd
	,"building_2_nm" VARCHAR(400)   ENCODE zstd
	,"city_nm" VARCHAR(280)   ENCODE zstd
	,"city_2_nm" VARCHAR(280)   ENCODE zstd
	,"city_3_nm" VARCHAR(280)   ENCODE zstd
	,"city_4_nm" VARCHAR(280)   ENCODE lzo
	,"province_nm" VARCHAR(400)   ENCODE lzo
	,"state_nm" VARCHAR(400)   ENCODE zstd
	,"district_cd" VARCHAR(160)   ENCODE zstd
	,"display_country_nm" VARCHAR(100)   ENCODE zstd
	,"country_iso_2_cd" VARCHAR(2)   ENCODE zstd
	,"country_iso_nm" VARCHAR(100)   ENCODE zstd
	,"postal_cd" VARCHAR(80)   ENCODE zstd
	,"postal_1_cd" VARCHAR(80)   ENCODE zstd
	,"postal_2_cd" VARCHAR(80)   ENCODE zstd
	,"address_validation_ind" CHAR(1)   ENCODE zstd
	,"customer_email_txt" VARCHAR(800)   ENCODE lzo
	,"phone_nbr" VARCHAR(30)   ENCODE lzo
	,"phone_country_dial_nbr" VARCHAR(25)   ENCODE lzo
	,"phone_country_display_nm" VARCHAR(100)   ENCODE lzo
	,"phone_country_iso_nm" VARCHAR(100)   ENCODE lzo
	,"phone_country_iso_cd" VARCHAR(2)   ENCODE lzo
	,"sms_phone_nbr" VARCHAR(30)   ENCODE lzo
	,"sms_country_dial_nbr" VARCHAR(20)   ENCODE lzo
	,"sms_country_display_nm" VARCHAR(100)   ENCODE lzo
	,"sms_country_iso_nm" VARCHAR(100)   ENCODE lzo
	,"sms_country_iso_cd" VARCHAR(2)   ENCODE lzo
	,"ecm_originated_country_nm" VARCHAR(100)   ENCODE lzo
	,"ecm_originated_country_cd" VARCHAR(2)   ENCODE lzo
	,"jde_customer_cd" VARCHAR(25)   ENCODE lzo
	,"account_source_nm" VARCHAR(25)   ENCODE lzo
	,"marketing_cd" VARCHAR(4)   ENCODE lzo
	,"marketing_dscr" VARCHAR(25)   ENCODE lzo
	,"month_opened_nbr" SMALLINT   ENCODE lzo
	,"year_opened_nbr" SMALLINT   ENCODE lzo
	,"payment_option_nm" VARCHAR(15)   ENCODE lzo
	,"search_type" VARCHAR(3)   ENCODE lzo
	,"current_se_cd" SMALLINT   ENCODE lzo
	,"source_recipient_id" BIGINT   ENCODE lzo
	,"recipient_black_list_email_sent_to_ecm_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_black_list_email_sent_to_ecm_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_email_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_fax_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_mobile_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_phone_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_post_mail_ind" SMALLINT   ENCODE lzo
	,"recipient_computed_gender_code" SMALLINT   ENCODE lzo
	,"recipient_computed_gender_dscr" VARCHAR(20)   ENCODE lzo
	,"recipient_ecard_opted_ind" SMALLINT   ENCODE lzo
	,"recipient_mbs_acclaim_customer_id" BIGINT   ENCODE lzo
	,"recipient_mbs_pc7_b2b_customer_id" BIGINT   ENCODE lzo
	,"recipient_mbs_pc7_b2c_customer_id" BIGINT   ENCODE lzo
	,"recipient_black_list_postal_mail_reason_cd" VARCHAR(25)   ENCODE lzo
	,"recipient_external_src_cd" VARCHAR(10)   ENCODE lzo
	,"recipient_external_src_dscr" VARCHAR(25)   ENCODE lzo
	,"recipient_src_file_nm" VARCHAR(1020)   ENCODE lzo
	,"recipient_outreach_country_numeric_cd" SMALLINT   ENCODE lzo
	,"recipient_outreach_country_dscr" VARCHAR(100)   ENCODE lzo
	,"recipient_black_list_email_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_black_list_postal_mail_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_external_src_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_external_src_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_last_click_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_last_opened_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_japan_opt_in_cd" SMALLINT   ENCODE lzo
	,"recipient_japan_opt_in_dscr" VARCHAR(25)   ENCODE lzo
	,"outreach_flg" SMALLINT   ENCODE lzo
	,"outreach_dscr" VARCHAR(50)   ENCODE lzo
	,"recipient_external_src_database_nm" VARCHAR(255)   ENCODE lzo
	,"recipient_external_src_database_dscr" VARCHAR(255)   ENCODE lzo
	,"client_level_type_id" SMALLINT   ENCODE lzo
	,"client_level_type_dscr" VARCHAR(50)   ENCODE lzo
	,"country_language_id" SMALLINT   ENCODE lzo
	,"country_language_dscr" VARCHAR(100)   ENCODE lzo
	,"recipient_contact_preference_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_contact_preference_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "source_recipient_id"
	, "crm_system_id"
	, "source_system_nm"
	, "ecm_customer_id"
	)
;
--DROP TABLE "edh"."audit_customer_email_dim";
CREATE TABLE IF NOT EXISTS "edh"."audit_customer_email_dim"
(
	"customer_email_key" BIGINT NOT NULL  ENCODE zstd
	,"customer_key" BIGINT   
	,"create_src_system_key" BIGINT   ENCODE lzo
	,"update_src_system_key" BIGINT   ENCODE lzo
	,"adobe_campaign_email_id" BIGINT   ENCODE lzo
	,"ecm_email_id" BIGINT   ENCODE zstd
	,"edw_email_id" BIGINT   ENCODE lzo
	,"email_source_nm" VARCHAR(3)   ENCODE zstd
	,"black_list_ecard_ind" SMALLINT   ENCODE lzo
	,"black_list_email_ind" SMALLINT   ENCODE lzo
	,"src_delete_ind" SMALLINT   ENCODE lzo
	,"primary_ind" SMALLINT   ENCODE zstd
	,"active_ind" SMALLINT   ENCODE zstd
	,"personalize_ind" SMALLINT   ENCODE lzo
	,"email_address_txt" VARCHAR(800)   ENCODE zstd
	,"external_src_database_nm" VARCHAR(1020)   ENCODE lzo
	,"black_list_ecard_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"black_list_email_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"src_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"src_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"opt_out_change_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"email_format_cd" BIGINT   ENCODE lzo
	,"email_format_dscr" VARCHAR(50)   ENCODE lzo
	,"email_type_cd" SMALLINT   ENCODE zstd
	,"email_type_dscr" VARCHAR(100)   ENCODE zstd
	,"active_ind_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"active_ind_create_user_nm" VARCHAR(20)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expire_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_email_key"
	, "customer_key"
	, "email_address_txt"
	, "email_source_nm"
	)
;
--DROP TABLE "edh"."audit_customer_level_history_fact";
CREATE TABLE IF NOT EXISTS "edh"."audit_customer_level_history_fact"
(
	"customer_key" BIGINT   ENCODE lzo
	,"client_level_id" VARCHAR(4)   ENCODE lzo
	,"client_level_dscr" VARCHAR(50)   ENCODE lzo
	,"source_system_nm" VARCHAR(20)   ENCODE lzo
	,"from_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_current_ind" CHAR(1)   ENCODE lzo
	,"tr_process_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
;
--DROP TABLE "edh"."audit_customer_name_fact";
CREATE TABLE IF NOT EXISTS "edh"."audit_customer_name_fact"
(
	"customer_key" BIGINT NOT NULL  
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"name_id" BIGINT NOT NULL  ENCODE zstd
	,"customer_title_txt" VARCHAR(400)   ENCODE zstd
	,"customer_first_nm" VARCHAR(200)   ENCODE zstd
	,"customer_last_nm" VARCHAR(400)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
SORTKEY (
	"customer_key"
	)
;
--DROP TABLE "edh"."audit_customer_phone_fact";
CREATE TABLE IF NOT EXISTS "edh"."audit_customer_phone_fact"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"create_source_system_key" BIGINT   ENCODE lzo
	,"update_source_system_key" BIGINT   ENCODE lzo
	,"customer_phone_id" BIGINT   ENCODE zstd
	,"phone_type_id" BIGINT   ENCODE zstd
	,"phone_type_dscr" VARCHAR(100)   ENCODE zstd
	,"fraud_type_id" BIGINT   ENCODE zstd
	,"fraud_type_dscr" VARCHAR(100)   ENCODE zstd
	,"phone_nbr" VARCHAR(30)   ENCODE zstd
	,"phone_extension_nbr" VARCHAR(10)   ENCODE zstd
	,"call_priority_nbr" INTEGER   ENCODE zstd
	,"phone_country_iso_cd" VARCHAR(2)   ENCODE zstd
	,"phone_country_iso_nm" VARCHAR(100)   ENCODE zstd
	,"phone_country_display_nm" VARCHAR(100)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"active_ind" SMALLINT   ENCODE zstd
	,"active_indicator_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"active_indicator_update_user_nm" VARCHAR(50)   ENCODE zstd
	,"primary_ind" SMALLINT   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"phone_type_id"
	, "phone_type_dscr"
	)
;
--DROP TABLE "edh"."audit_customer_preferred_interest_fact";
CREATE TABLE IF NOT EXISTS "edh"."audit_customer_preferred_interest_fact"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"customer_preferred_interest_id" BIGINT   ENCODE zstd
	,"interest_type_id" BIGINT   ENCODE zstd
	,"interest_type_dscr" VARCHAR(100)   ENCODE zstd
	,"parent_interest_type_id" BIGINT   ENCODE zstd
	,"parent_interest_type_dscr" VARCHAR(100)   ENCODE zstd
	,"interest_dt" DATE   ENCODE zstd
	,"comment_txt" VARCHAR(16000)   ENCODE zstd
	,"calendar_type_id" SMALLINT   ENCODE zstd
	,"calendar_type_dscr" VARCHAR(100)   ENCODE zstd
	,"value_id" SMALLINT   ENCODE zstd
	,"value_dscr" VARCHAR(25)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_updated_user" VARCHAR(20)   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"interest_type_id"
	, "interest_type_dscr"
	)
;
--DROP TABLE "edh"."audit_experian_aus_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."audit_experian_aus_customer_dim"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"mosaic_group_nm" VARCHAR(255)   ENCODE zstd
	,"mosaic_type_group_cd" VARCHAR(20)   ENCODE bytedict
	,"mosaic_type_group_dscr" VARCHAR(255)   ENCODE zstd
	,"age_cd" VARCHAR(20)   ENCODE zstd
	,"age_cd_dscr" VARCHAR(255)   ENCODE zstd
	,"household_income_cd" VARCHAR(25)   ENCODE zstd
	,"household_income_cd_dscr" VARCHAR(25)   ENCODE bytedict
	,"children_aged_0_11_qty" SMALLINT   ENCODE lzo
	,"children_aged_11_18_qty" SMALLINT   ENCODE lzo
	,"household_relationship_group_cd" VARCHAR(20)   ENCODE zstd
	,"household_relationship_group_cd_dscr" VARCHAR(255)   ENCODE zstd
	,"gender_dscr" VARCHAR(20)   ENCODE zstd
	,"occupation_dscr" VARCHAR(255)   ENCODE zstd
	,"model_generated_decimal_nbr" NUMERIC(20,5)   ENCODE zstd
	,"model_generated_decimal_val" NUMERIC(10,6)   ENCODE bytedict
	,"factor_4_wealth_score_nbr" BIGINT   ENCODE mostly16
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
SORTKEY (
	"ecm_customer_id"
	)
;
--DROP TABLE "edh"."audit_experian_uk_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."audit_experian_uk_customer_dim"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"gender_cd" VARCHAR(1)   ENCODE zstd
	,"gender_dscr" VARCHAR(15)   ENCODE zstd
	,"person_age_line_cd" VARCHAR(2)   ENCODE zstd
	,"person_age_line_dscr" VARCHAR(15)   ENCODE zstd
	,"household_income_band_cd" CHAR(1)   ENCODE zstd
	,"household_income_band_dscr" VARCHAR(40)   ENCODE zstd
	,"net_worth_level_cd" VARCHAR(1)   ENCODE zstd
	,"net_worth_level_dscr" VARCHAR(15)   ENCODE zstd
	,"marital_status_cd" CHAR(25)   ENCODE zstd
	,"marital_status_dscr" VARCHAR(20)   ENCODE zstd
	,"person_mosaic_shopper_type_cd" CHAR(3)   ENCODE zstd
	,"person_mosaic_shopper_type_dscr" VARCHAR(25)   ENCODE bytedict
	,"household_mosaic_uk_6_group_cd" CHAR(1)   ENCODE zstd
	,"household_mosaic_uk_6_group_dscr" VARCHAR(50)   ENCODE zstd
	,"household_mosaic_uk_6_type_cd" CHAR(2)   ENCODE zstd
	,"household_mosaic_uk_6_type_dscr" VARCHAR(50)   ENCODE zstd
	,"postcard_mosaic_uk_6_group_cd" CHAR(1)   ENCODE zstd
	,"postcard_mosaic_uk_6_group_dscr" VARCHAR(50)   ENCODE zstd
	,"postcard_mosaic_uk_6_type_cd" CHAR(2)   ENCODE zstd
	,"postcard_mosaic_uk_6_type_dscr" VARCHAR(50)   ENCODE zstd
	,"experian_person_key" NUMERIC(10,0)   ENCODE lzo
	,"experian_household_key" NUMERIC(19,0)   ENCODE lzo
	,"new_age_band" VARCHAR(20)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
SORTKEY (
	"ecm_customer_id"
	)
;
--DROP TABLE "edh"."audit_lookup_recipientemail";
CREATE TABLE IF NOT EXISTS "edh"."audit_lookup_recipientemail"
(
	"recipient_email_id" BIGINT NOT NULL  ENCODE delta
	,"customer_key" BIGINT   
	,"recipient_id" BIGINT   
	,"ecm_customer_id" BIGINT   
	,"email_address_txt" VARCHAR(1600)   
	,"email_domain_nm" VARCHAR(1600)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("ecm_customer_id")
SORTKEY (
	"ecm_customer_id"
	, "recipient_id"
	, "customer_key"
	, "email_address_txt"
	, "recipient_email_id"
	)
;
--DROP TABLE "edh"."audit_millward_brown_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."audit_millward_brown_customer_dim"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"primary_segment_cd" VARCHAR(5)   ENCODE zstd
	,"primary_segment_dscr" VARCHAR(50)   ENCODE zstd
	,"secondary_segment_cd" VARCHAR(5)   ENCODE zstd
	,"secondary_segment_dscr" VARCHAR(50)   ENCODE zstd
	,"primary_segment_probability_rt" NUMERIC(10,6)   ENCODE zstd
	,"secondary_segment_probability_rt" NUMERIC(10,6)   ENCODE zstd
	,"rus_flg" VARCHAR(3)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
SORTKEY (
	"primary_segment_cd"
	)
;
--DROP TABLE "edh"."audit_subscription_dim";
CREATE TABLE IF NOT EXISTS "edh"."audit_subscription_dim"
(
	"subscription_key" BIGINT NOT NULL  ENCODE zstd
	,"customer_key" BIGINT   
	,"service_id" BIGINT   ENCODE zstd
	,"service_label_txt" VARCHAR(512)   ENCODE zstd
	,"service_nm" VARCHAR(256)   ENCODE zstd
	,"subscription_control_ind" SMALLINT   ENCODE zstd
	,"recipient_id" BIGINT   ENCODE zstd
	,"engagement_ready_to_send_ind" SMALLINT   ENCODE zstd
	,"cohort_cd" VARCHAR(100)   ENCODE zstd
	,"cohort_dscr" VARCHAR(100)   ENCODE zstd
	,"log_txt" VARCHAR(400)   ENCODE zstd
	,"phase_txt" VARCHAR(200)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"entered_cohord_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"householding_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"left_cohort_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"subscription_transaction_id" BIGINT   ENCODE zstd
	,"subscription_transaction_invoice_nbr" VARCHAR(60)   ENCODE zstd
	,"delete_status_cd" SMALLINT   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "service_label_txt"
	, "cohort_cd"
	, "subscription_control_ind"
	)
;
--DROP TABLE "edh"."audit_wealth_engine_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."audit_wealth_engine_customer_dim"
(
	"customer_key" BIGINT NOT NULL  
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"net_worth_amt" VARCHAR(20)   ENCODE bytedict
	,"household_income_amt" VARCHAR(20)   ENCODE bytedict
	,"birth_dt" VARCHAR(10)   ENCODE zstd
	,"gender_cd" CHAR(1)   ENCODE zstd
	,"gender_dscr" VARCHAR(20)   ENCODE zstd
	,"marital_status_cd" CHAR(1)   ENCODE zstd
	,"marital_status_dscr" VARCHAR(20)   ENCODE zstd
	,"p2g_score_nbr" VARCHAR(50)   ENCODE zstd
	,"non_profit_board_flg" VARCHAR(3)   ENCODE zstd
	,"retail_purchaser_ind" VARCHAR(1)   ENCODE zstd
	,"living_upscale_ind" VARCHAR(1)   ENCODE zstd
	,"sport_code_ss_rollup_ind" VARCHAR(1)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"audit_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
SORTKEY (
	"customer_key"
	)
;
--DROP TABLE "edh"."cd100_portcust_sp";
CREATE TABLE IF NOT EXISTS "edh"."cd100_portcust_sp"
(
	"assigned_clerk_key" BIGINT   ENCODE lzo
	,"employee_nbr" VARCHAR(11)   ENCODE lzo
	,"store_nbr" INTEGER   ENCODE lzo
	,"client_type_dscr" VARCHAR(100)   ENCODE lzo
	,"customer_cnt" BIGINT   ENCODE lzo
	,"report_date_key" BIGINT   ENCODE lzo
	,"assigned_channel_key" BIGINT   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."cd100_portfolio_customers";
CREATE TABLE IF NOT EXISTS "edh"."cd100_portfolio_customers"
(
	"report_date_key" BIGINT   ENCODE lzo
	,"portfolio_customer_key" BIGINT   ENCODE lzo
	,"assigned_clerk_key" BIGINT   ENCODE lzo
	,"assigned_channel_key" BIGINT   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."cd100_portsales_repeat_cust";
CREATE TABLE IF NOT EXISTS "edh"."cd100_portsales_repeat_cust"
(
	"report_date_time" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"assigned_clerk_key" BIGINT   ENCODE lzo
	,"repeat_customer_key" BIGINT   ENCODE lzo
	,"assigned_channel_key" BIGINT   ENCODE lzo
	,"ppy_purchase_flag" INTEGER   ENCODE lzo
	,"py_purchase_flag" INTEGER   ENCODE lzo
	,"fytd_purchase_flag" INTEGER   ENCODE lzo
	,"ppy_total_sales" NUMERIC(38,5)   ENCODE lzo
	,"py_total_sales" NUMERIC(38,5)   ENCODE lzo
	,"fytd_total_sales" NUMERIC(38,5)   ENCODE lzo
	,"end_of_period_date_key" INTEGER   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."cd100_portsales_sp_biweekly";
CREATE TABLE IF NOT EXISTS "edh"."cd100_portsales_sp_biweekly"
(
	"report_date_time" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"assigned_clerk_key" BIGINT   ENCODE lzo
	,"clerk_key" BIGINT   ENCODE lzo
	,"employee_number" VARCHAR(11)   ENCODE lzo
	,"assigned_employee_code" VARCHAR(11)   ENCODE lzo
	,"customer_key" BIGINT   ENCODE lzo
	,"client_type_description" VARCHAR(100)   ENCODE lzo
	,"sum_period_yyyymm" VARCHAR(6)   ENCODE lzo
	,"sum_period_month_half" INTEGER   ENCODE lzo
	,"end_of_period_date_key" BIGINT   ENCODE lzo
	,"sum_ext_price_lc_taxincl" NUMERIC(38,5)   ENCODE lzo
	,"mysale_flag" INTEGER   ENCODE lzo
	,"net_transactions" INTEGER   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."cd100_portsales_store_biweekly";
CREATE TABLE IF NOT EXISTS "edh"."cd100_portsales_store_biweekly"
(
	"report_date_time" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"channel_key" BIGINT   ENCODE lzo
	,"clerk_key" BIGINT   ENCODE lzo
	,"employee_number" VARCHAR(11)   ENCODE lzo
	,"customer_key" BIGINT   ENCODE lzo
	,"period_cd" VARCHAR(7)   ENCODE lzo
	,"end_of_period_date_key" BIGINT   ENCODE lzo
	,"sum_ext_price_lc_taxincl" NUMERIC(38,5)   ENCODE lzo
	,"sum_ext_price_usd_taxincl" NUMERIC(38,5)   ENCODE lzo
	,"instore_sale_ind" INTEGER   ENCODE lzo
	,"selling_channel_key" BIGINT   ENCODE lzo
	,"net_transactions" INTEGER   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."cd100_ref_chnl_key_lkp_tmp";
CREATE TABLE IF NOT EXISTS "edh"."cd100_ref_chnl_key_lkp_tmp"
(
	"order_company" VARCHAR(255)   
	,"business_unit" VARCHAR(255)   
	,"transaction_type" VARCHAR(255)   
	,"customer_number" VARCHAR(255)   
	,"channel" VARCHAR(3)   
	,"financial_location" VARCHAR(255)   
	,"subchannel" VARCHAR(255)   
	,"floor" VARCHAR(255)   
	,"department" VARCHAR(255)   
	,"japan_revenue_center" VARCHAR(255)   
	,"channel_dim_channel_key" VARCHAR(255)   
	,"src_channel_key" VARCHAR(255)   
	,"src_table_nm" VARCHAR(255)   
	,"create_ts" VARCHAR(255)   
	,"update_ts" VARCHAR(255)   
	,"revenue_center" VARCHAR(255)   
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."cd100_regcust_sales";
CREATE TABLE IF NOT EXISTS "edh"."cd100_regcust_sales"
(
	"report_date_time" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"purchaser_customer_key" BIGINT   ENCODE lzo
	,"selling_channel_key" BIGINT   ENCODE lzo
	,"selling_clerk_key" BIGINT   ENCODE lzo
	,"customer_tourist_type" VARCHAR(20)   ENCODE lzo
	,"ppy_purchase_flag" INTEGER   ENCODE lzo
	,"py_purchase_flag" INTEGER   ENCODE lzo
	,"pytd_purchase_flag" INTEGER   ENCODE lzo
	,"fytd_purchase_flag" INTEGER   ENCODE lzo
	,"ppy_total_sales" NUMERIC(38,5)   ENCODE lzo
	,"py_total_sales" NUMERIC(38,5)   ENCODE lzo
	,"pytd_total_sales" NUMERIC(38,5)   ENCODE lzo
	,"fytd_total_sales" NUMERIC(38,5)   ENCODE lzo
	,"end_of_period_date_key" BIGINT   ENCODE lzo
	,"net_transactions" BIGINT   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."cd100_total_transactions";
CREATE TABLE IF NOT EXISTS "edh"."cd100_total_transactions"
(
	"report_date_time" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"customer_key" BIGINT   ENCODE lzo
	,"selling_channel_key" BIGINT   ENCODE lzo
	,"selling_clerk_key" BIGINT   ENCODE lzo
	,"ppy_total_transaction_sales" NUMERIC(38,5)   ENCODE lzo
	,"py_total_transaction_sales" NUMERIC(38,5)   ENCODE lzo
	,"pytd_total_transaction_sales" NUMERIC(38,5)   ENCODE lzo
	,"fytd_total_transaction_sales" NUMERIC(38,5)   ENCODE lzo
	,"end_of_period_date_key" BIGINT   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."channel_dim";
CREATE TABLE IF NOT EXISTS "edh"."channel_dim"
(
	"channel_key" BIGINT NOT NULL DEFAULT "identity"(394886, 0, '1,1'::text) ENCODE lzo
	,"source_channel_key" BIGINT NOT NULL  
	,"revenue_center_nm" VARCHAR(40)   ENCODE lzo
	,"business_group_nm" VARCHAR(25)   
	,"domestic_international_type" VARCHAR(25)   ENCODE lzo
	,"sales_division_nm" VARCHAR(25)   
	,"channel_nm" VARCHAR(25)   
	,"sub_channel_nm" VARCHAR(25)   ENCODE lzo
	,"company_nbr" VARCHAR(5)   ENCODE lzo
	,"company_nm" VARCHAR(40)   ENCODE lzo
	,"currency_cd" VARCHAR(3)   ENCODE lzo
	,"currency_symbol_txt" VARCHAR(10)   ENCODE lzo
	,"part_of_the_world_nm" VARCHAR(25)   ENCODE lzo
	,"sub_part_of_the_world_nm" VARCHAR(25)   ENCODE lzo
	,"display_country_nm" VARCHAR(100)   
	,"iso_country_cd" VARCHAR(2)   ENCODE lzo
	,"iso_country_nm" VARCHAR(100)   ENCODE lzo
	,"region_nm" VARCHAR(25)   ENCODE lzo
	,"territory_nm" VARCHAR(25)   ENCODE lzo
	,"location_nm" VARCHAR(40)   ENCODE lzo
	,"trade_account_nbr" VARCHAR(25)   ENCODE lzo
	,"dgp_receiving_company_nbr" VARCHAR(25)   ENCODE lzo
	,"retail_chain_nm" VARCHAR(25)   ENCODE lzo
	,"revenue_center_type" VARCHAR(40)   
	,"chain_txt" VARCHAR(25)   ENCODE lzo
	,"new_comparable_type" VARCHAR(15)   ENCODE lzo
	,"store_open_dt" DATE   ENCODE lzo
	,"store_close_dt" DATE   ENCODE lzo
	,"comparable_dt" DATE   ENCODE lzo
	,"mips_store_nbr" BIGINT   ENCODE lzo
	,"mips_store_nm" VARCHAR(40)   ENCODE lzo
	,"closed_days_group_cd" VARCHAR(10)   ENCODE lzo
	,"logility_store_nbr" BIGINT   ENCODE lzo
	,"logility_region_cd" VARCHAR(5)   ENCODE lzo
	,"logility_channel_nbr" BIGINT   ENCODE lzo
	,"region_sort_nbr" INTEGER   ENCODE lzo
	,"part_of_the_world_sort_nbr" INTEGER   ENCODE lzo
	,"group_channel_sub_channel_sort_nbr" INTEGER   ENCODE lzo
	,"business_type_sort_nbr" INTEGER   ENCODE lzo
	,"business_type" VARCHAR(25)   ENCODE lzo
	,"unified_channel_nm" VARCHAR(25)   
	,"unified_sub_channel_nm" VARCHAR(25)   
	,"plan_open_dt" DATE   ENCODE lzo
	,"store_size_txt" VARCHAR(25)   ENCODE lzo
	,"store_city_nm" VARCHAR(25)   ENCODE lzo
	,"store_state_province_cd" VARCHAR(2)   ENCODE lzo
	,"segment_summary_nm" VARCHAR(25)   ENCODE lzo
	,"segment_nm" VARCHAR(25)   ENCODE lzo
	,"sub_segment_nm" VARCHAR(25)   ENCODE lzo
	,"segment_sort_order_nbr" INTEGER   ENCODE lzo
	,"territory_sort_order_nbr" INTEGER   ENCODE lzo
	,"merch_store_size_txt" VARCHAR(25)   ENCODE lzo
	,"store_alpha_cd" VARCHAR(2)   ENCODE lzo
	,"price_market_nm" VARCHAR(25)   ENCODE lzo
	,"global_region_summary_nm" VARCHAR(25)   ENCODE lzo
	,"public_global_region_nm" VARCHAR(25)   ENCODE lzo
	,"global_region_nm" VARCHAR(25)   ENCODE lzo
	,"global_sub_region_nm" VARCHAR(25)   ENCODE lzo
	,"global_region_sort_nbr" INTEGER   ENCODE lzo
	,"merch_region_nm" VARCHAR(25)   ENCODE lzo
	,"merch_market_nm" VARCHAR(25)   ENCODE lzo
	,"store_longitude_nbr" VARCHAR(30)   ENCODE lzo
	,"store_latitude_nbr" VARCHAR(30)   ENCODE lzo
	,"store_postal_cd" VARCHAR(25)   ENCODE lzo
	,"include_in_sales_flg" VARCHAR(1)   ENCODE lzo
	,"include_in_inventory_flg" VARCHAR(1)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (channel_key)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"source_channel_key"
	, "business_group_nm"
	, "sales_division_nm"
	, "revenue_center_type"
	, "channel_nm"
	, "display_country_nm"
	, "unified_channel_nm"
	, "unified_sub_channel_nm"
	)
;
--DROP TABLE "edh"."clerk_dim";
CREATE TABLE IF NOT EXISTS "edh"."clerk_dim"
(
	"clerk_key" BIGINT NOT NULL DEFAULT "identity"(394891, 0, '1,1'::text) ENCODE zstd
	,"source_clerk_key" BIGINT NOT NULL  ENCODE delta32k
	,"clerk_id" BIGINT NOT NULL  ENCODE zstd
	,"active_record_ind" VARCHAR(1)   ENCODE zstd
	,"clerk_first_nm" VARCHAR(50)   ENCODE zstd
	,"clerk_last_nm" VARCHAR(50)   ENCODE zstd
	,"clerk_class_txt" VARCHAR(10)   ENCODE zstd
	,"employee_nbr" VARCHAR(11)   ENCODE zstd
	,"company_nbr" VARCHAR(5)   ENCODE zstd
	,"channel_type" VARCHAR(9)   ENCODE zstd
	,"floor_txt" VARCHAR(10)   ENCODE lzo
	,"job_cd" VARCHAR(6)   ENCODE zstd
	,"commisionable_ind" VARCHAR(1)   ENCODE lzo
	,"clerk_status_txt" VARCHAR(8)   ENCODE zstd
	,"status_dt" DATE   ENCODE lzo
	,"store_nbr" INTEGER   ENCODE lzo
	,"iso_country_cd" VARCHAR(2)   ENCODE zstd
	,"iso_country_nm" VARCHAR(100)   ENCODE zstd
	,"country_display_nm" VARCHAR(100)   ENCODE zstd
	,"location_nm" VARCHAR(40)   ENCODE zstd
	,"region_nm" VARCHAR(25)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (clerk_key)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"clerk_id"
	, "clerk_status_txt"
	, "location_nm"
	, "region_nm"
	, "country_display_nm"
	, "employee_nbr"
	)
;
--DROP TABLE "edh"."clerk_group_dim";
CREATE TABLE IF NOT EXISTS "edh"."clerk_group_dim"
(
	"clerk_group_key" BIGINT NOT NULL DEFAULT "identity"(394896, 0, '1,1'::text) ENCODE zstd
	,"source_clerk_group_key" BIGINT   ENCODE zstd
	,"clerk_key" BIGINT   ENCODE zstd
	,"clerks_in_group_qty" SMALLINT   ENCODE zstd
	,"clerk_sequence_nbr" SMALLINT   ENCODE zstd
	,"weighting_factor_rt" NUMERIC(3,1)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (clerk_group_key)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"clerk_group_key"
	, "clerk_key"
	)
;
--DROP TABLE "edh"."clienteling_action_opportunity_attr_dim";
CREATE TABLE IF NOT EXISTS "edh"."clienteling_action_opportunity_attr_dim"
(
	"clienteling_act_opp_attribute_key" BIGINT NOT NULL DEFAULT "identity"(471487, 0, '1,1'::text) ENCODE lzo
	,"action_item_type_cd" BIGINT   ENCODE lzo
	,"action_item_type_dscr" VARCHAR(100)   ENCODE lzo
	,"action_priority_type_cd" BIGINT   ENCODE lzo
	,"action_priority_type_dscr" VARCHAR(100)   ENCODE lzo
	,"outreach_action_reason_type_cd" BIGINT   ENCODE lzo
	,"outreach_action_reason_type_dscr" VARCHAR(100)   ENCODE lzo
	,"outreach_action_method_type_cd" BIGINT   ENCODE lzo
	,"outreach_action_method_type_dscr" VARCHAR(100)   ENCODE lzo
	,"action_initiative_type_cd" BIGINT   ENCODE lzo
	,"action_initiative_type_dscr" VARCHAR(100)   ENCODE lzo
	,"action_status_type_cd" BIGINT   ENCODE lzo
	,"action_status_type_dscr" VARCHAR(100)   ENCODE lzo
	,"action_gift_type_cd" BIGINT   ENCODE lzo
	,"action_gift_type_dscr" VARCHAR(100)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."clienteling_action_opportunity_fact";
CREATE TABLE IF NOT EXISTS "edh"."clienteling_action_opportunity_fact"
(
	"clienteling_action_opportunity_key" BIGINT NOT NULL DEFAULT "identity"(471490, 0, '1,1'::text) ENCODE lzo
	,"source_action_opportunity_key" BIGINT NOT NULL  ENCODE lzo
	,"clienteling_act_opp_attribute_key" BIGINT   ENCODE lzo
	,"creator_clerk_key" BIGINT   ENCODE lzo
	,"assigned_to_clerk_key" BIGINT   ENCODE lzo
	,"assigned_clerk_key" BIGINT   ENCODE lzo
	,"associated_channel_key" BIGINT   ENCODE lzo
	,"customer_key" BIGINT   ENCODE lzo
	,"gift_product_sku" VARCHAR(20)   ENCODE lzo
	,"gift_country_id" BIGINT   ENCODE lzo
	,"gift_retail_value_local_currency_amount" NUMERIC(38,5)   ENCODE lzo
	,"gift_description" VARCHAR(1000)   ENCODE lzo
	,"source_country_id" BIGINT   ENCODE lzo
	,"created_date_key" BIGINT   ENCODE lzo
	,"due_date_key" BIGINT   ENCODE lzo
	,"completed_date_key" BIGINT   ENCODE lzo
	,"modified_date_key" BIGINT   ENCODE lzo
	,"consultation_date_key" BIGINT   ENCODE lzo
	,"associated_store_nbr" BIGINT   ENCODE lzo
	,"created_by_id" VARCHAR(20)   ENCODE lzo
	,"modified_by_id" VARCHAR(20)   ENCODE lzo
	,"reviewed_by_id" VARCHAR(20)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"load_script_nm" VARCHAR(300)   ENCODE lzo
	,"stg_mapping_nm" VARCHAR(100)   ENCODE lzo
	,"stg_workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (clienteling_action_opportunity_key)
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."clienteling_emp_task_attr_dim";
CREATE TABLE IF NOT EXISTS "edh"."clienteling_emp_task_attr_dim"
(
	"clienteling_emp_task_attr_key" BIGINT NOT NULL DEFAULT "identity"(471500, 0, '1,1'::text) ENCODE lzo
	,"task_type_cd" BIGINT   ENCODE lzo
	,"task_type_dscr" VARCHAR(100)   ENCODE lzo
	,"task_outcome_cd" BIGINT   ENCODE lzo
	,"task_outcome_dscr" VARCHAR(100)   ENCODE lzo
	,"customer_contact_reason_cd" BIGINT   ENCODE lzo
	,"customer_contact_reason_dscr" VARCHAR(160)   ENCODE lzo
	,"task_initiative_cd" BIGINT   ENCODE lzo
	,"task_initiative_dscr" VARCHAR(100)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."clienteling_employee_task_fact";
CREATE TABLE IF NOT EXISTS "edh"."clienteling_employee_task_fact"
(
	"clienteling_employee_task_key" BIGINT NOT NULL DEFAULT "identity"(471495, 0, '1,1'::text) ENCODE lzo
	,"source_cl_employee_task_key" BIGINT NOT NULL  ENCODE lzo
	,"customer_key" BIGINT   ENCODE lzo
	,"assigned_to_clerk_key" BIGINT   ENCODE lzo
	,"receiver_creator_clerk_key" BIGINT   ENCODE lzo
	,"created_date_key" BIGINT   ENCODE lzo
	,"due_date_key" BIGINT   ENCODE lzo
	,"completed_date_key" BIGINT   ENCODE lzo
	,"reminder_date_key" BIGINT   ENCODE lzo
	,"clienteling_emp_task_attr_key" BIGINT   ENCODE lzo
	,"cust_email_contact_task_key" BIGINT   ENCODE lzo
	,"channel_key" BIGINT   ENCODE lzo
	,"source_country_id" BIGINT   ENCODE lzo
	,"is_complete_flag" INTEGER   ENCODE lzo
	,"task_title_txt" VARCHAR(1000)   ENCODE lzo
	,"task_description_txt" VARCHAR(1000)   ENCODE lzo
	,"store_nbr" BIGINT   ENCODE lzo
	,"priority_nbr" INTEGER   ENCODE lzo
	,"reminder_duration_nbr" INTEGER   ENCODE lzo
	,"created_by_nm" VARCHAR(20)   ENCODE lzo
	,"modified_by_nm" VARCHAR(20)   ENCODE lzo
	,"reviewed_by_nm" VARCHAR(20)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"load_script_nm" VARCHAR(300)   ENCODE lzo
	,"stg_mapping_nm" VARCHAR(255)   ENCODE lzo
	,"stg_workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,"comment_txt" VARCHAR(4000)   ENCODE lzo
	,PRIMARY KEY (clienteling_employee_task_key)
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."country_master";
CREATE TABLE IF NOT EXISTS "edh"."country_master"
(
	"country_id" BIGINT NOT NULL  ENCODE lzo
	,"country_iso_2_char_cd" VARCHAR(2)   
	,"country_iso_3_char_cd" VARCHAR(3)   ENCODE lzo
	,"country_iso_numeric_cd" VARCHAR(3)   ENCODE lzo
	,"country_iso_nm" VARCHAR(100)   ENCODE lzo
	,"country_display_nm" VARCHAR(100)   
	,"country_fips104_cd" VARCHAR(50)   ENCODE lzo
	,"country_currency_cd" VARCHAR(3)   ENCODE lzo
	,"country_dial_cd" VARCHAR(25)   ENCODE lzo
	,"nationality_singular_nm" VARCHAR(100)   ENCODE lzo
	,"nationality_plural_nm" VARCHAR(100)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (country_id)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"country_iso_2_char_cd"
	, "country_display_nm"
	)
;
--DROP TABLE "edh"."currency_master";
CREATE TABLE IF NOT EXISTS "edh"."currency_master"
(
	"currency_cd" VARCHAR(3) NOT NULL  
	,"currency_numeric_cd" SMALLINT   ENCODE lzo
	,"currency_nm" VARCHAR(100)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (currency_cd)
)
DISTSTYLE ALL
SORTKEY (
	"currency_cd"
	)
;
--DROP TABLE "edh"."customer_address_fact";
CREATE TABLE IF NOT EXISTS "edh"."customer_address_fact"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"create_source_system_key" BIGINT   ENCODE lzo
	,"update_source_system_key" BIGINT   ENCODE lzo
	,"address_id" BIGINT NOT NULL  ENCODE lzo
	,"customer_address_id" BIGINT NOT NULL  ENCODE lzo
	,"address_type_id" BIGINT   
	,"address_type_dscr" VARCHAR(100)   
	,"fraud_type_id" BIGINT   ENCODE lzo
	,"fraud_type_dscr" VARCHAR(50)   ENCODE lzo
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"primary_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"address_type_id"
	, "address_type_dscr"
	)
;
--DROP TABLE "edh"."customer_bio_fact";
CREATE TABLE IF NOT EXISTS "edh"."customer_bio_fact"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"bio_category_selection_id" BIGINT NOT NULL  ENCODE zstd
	,"bio_category_hierarchy_id" BIGINT   ENCODE zstd
	,"bio_category_parent_type_nm" VARCHAR(160)   ENCODE zstd
	,"bio_category_child_type_nm" VARCHAR(160)   ENCODE zstd
	,"notes_txt" VARCHAR(16000)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE NOT NULL  ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE NOT NULL  ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"bio_category_parent_type_nm"
	, "bio_category_child_type_nm"
	)
;
--DROP TABLE "edh"."customer_comment_fact";
CREATE TABLE IF NOT EXISTS "edh"."customer_comment_fact"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"comment_id" BIGINT NOT NULL  ENCODE zstd
	,"comment_type_id" BIGINT NOT NULL  ENCODE zstd
	,"comment_type_dscr" VARCHAR(50)   ENCODE zstd
	,"comment_txt" VARCHAR(16000)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"comment_type_id"
	, "comment_type_dscr"
	)
;
--DROP TABLE "edh"."customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."customer_dim"
(
	"customer_key" BIGINT NOT NULL DEFAULT "identity"(394915, 0, '1,1'::text) 
	,"create_source_system_key" BIGINT   ENCODE lzo
	,"update_source_system_key" BIGINT   ENCODE lzo
	,"original_system_nm" VARCHAR(30)   ENCODE lzo
	,"source_customer_key" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"crm_system_id" BIGINT   ENCODE zstd
	,"customer_nbr" BIGINT   ENCODE zstd
	,"source_system_nm" VARCHAR(20)   ENCODE lzo
	,"source_created_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_last_updt_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"client_type_id" SMALLINT   ENCODE lzo
	,"client_type_dscr" VARCHAR(100)   ENCODE lzo
	,"assigned_employee_cd" VARCHAR(11)   ENCODE lzo
	,"customer_title_txt" VARCHAR(400)   ENCODE lzo
	,"customer_salutation_nm" VARCHAR(400)   ENCODE lzo
	,"customer_first_nm" VARCHAR(200)   ENCODE lzo
	,"customer_middle_nm" VARCHAR(200)   ENCODE lzo
	,"customer_last_nm" VARCHAR(400)   ENCODE lzo
	,"customer_suffix_txt" VARCHAR(320)   ENCODE lzo
	,"customer_full_nm" VARCHAR(400)   ENCODE lzo
	,"customer_post_nm" VARCHAR(400)   ENCODE lzo
	,"employee_ind" SMALLINT   ENCODE lzo
	,"employee_nbr" VARCHAR(11)   ENCODE lzo
	,"gender_nm" VARCHAR(20)   ENCODE lzo
	,"birth_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"customer_marital_status_cd" VARCHAR(1)   ENCODE lzo
	,"customer_marital_status_dscr" VARCHAR(100)   ENCODE lzo
	,"customer_nationality" VARCHAR(50)   ENCODE lzo
	,"first_purchase_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_purchased_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"spend_36_months_amt" NUMERIC(20,5)   ENCODE lzo
	,"spend_lifetime_amt" NUMERIC(20,5)   ENCODE lzo
	,"tr_cd" VARCHAR(4)   ENCODE lzo
	,"tr_dscr" VARCHAR(25)   ENCODE lzo
	,"ecm_active_ind" SMALLINT   ENCODE lzo
	,"cic_flg" CHAR(1)   ENCODE lzo
	,"cic_updt_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"allow_mail_ind" CHAR(1)   ENCODE lzo
	,"allow_email_ind" CHAR(1)   ENCODE lzo
	,"allow_phone_ind" CHAR(1)   ENCODE lzo
	,"allow_txt_ind" CHAR(1)   ENCODE lzo
	,"address_ind" SMALLINT   ENCODE lzo
	,"email_ind" SMALLINT   ENCODE lzo
	,"phone_ind" VARCHAR(25)   ENCODE lzo
	,"household_id" INTEGER   ENCODE lzo
	,"household_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"household_salutation_txt" VARCHAR(800)   ENCODE lzo
	,"household_relationship_type" VARCHAR(25)   ENCODE lzo
	,"household_relationship_driver_ind" VARCHAR(25)   ENCODE lzo
	,"address_line_1_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_2_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_3_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_4_txt" VARCHAR(400)   ENCODE lzo
	,"building_nm" VARCHAR(400)   ENCODE zstd
	,"building_2_nm" VARCHAR(400)   ENCODE zstd
	,"city_nm" VARCHAR(280)   ENCODE zstd
	,"city_2_nm" VARCHAR(280)   ENCODE zstd
	,"city_3_nm" VARCHAR(280)   ENCODE zstd
	,"city_4_nm" VARCHAR(280)   ENCODE lzo
	,"province_nm" VARCHAR(400)   ENCODE lzo
	,"state_nm" VARCHAR(400)   ENCODE zstd
	,"district_cd" VARCHAR(160)   ENCODE zstd
	,"display_country_nm" VARCHAR(100)   ENCODE zstd
	,"country_iso_2_cd" VARCHAR(2)   ENCODE zstd
	,"country_iso_nm" VARCHAR(100)   ENCODE zstd
	,"postal_cd" VARCHAR(80)   ENCODE zstd
	,"postal_1_cd" VARCHAR(80)   ENCODE zstd
	,"postal_2_cd" VARCHAR(80)   ENCODE zstd
	,"address_validation_ind" CHAR(1)   ENCODE zstd
	,"customer_email_txt" VARCHAR(800)   ENCODE lzo
	,"phone_nbr" VARCHAR(30)   ENCODE lzo
	,"phone_country_dial_nbr" VARCHAR(25)   ENCODE lzo
	,"phone_country_display_nm" VARCHAR(100)   ENCODE lzo
	,"phone_country_iso_nm" VARCHAR(100)   ENCODE lzo
	,"phone_country_iso_cd" VARCHAR(2)   ENCODE lzo
	,"sms_phone_nbr" VARCHAR(30)   ENCODE lzo
	,"sms_country_dial_nbr" VARCHAR(20)   ENCODE lzo
	,"sms_country_display_nm" VARCHAR(100)   ENCODE lzo
	,"sms_country_iso_nm" VARCHAR(100)   ENCODE lzo
	,"sms_country_iso_cd" VARCHAR(2)   ENCODE lzo
	,"ecm_originated_country_nm" VARCHAR(100)   ENCODE lzo
	,"ecm_originated_country_cd" VARCHAR(2)   ENCODE lzo
	,"jde_customer_cd" VARCHAR(25)   ENCODE lzo
	,"account_source_nm" VARCHAR(25)   ENCODE lzo
	,"marketing_cd" VARCHAR(4)   ENCODE lzo
	,"marketing_dscr" VARCHAR(25)   ENCODE lzo
	,"month_opened_nbr" SMALLINT   ENCODE lzo
	,"year_opened_nbr" SMALLINT   ENCODE lzo
	,"payment_option_nm" VARCHAR(15)   ENCODE lzo
	,"search_type" VARCHAR(3)   ENCODE lzo
	,"current_se_cd" SMALLINT   ENCODE lzo
	,"source_recipient_id" BIGINT   ENCODE lzo
	,"recipient_black_list_email_sent_to_ecm_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_black_list_email_sent_to_ecm_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_email_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_fax_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_mobile_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_phone_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_post_mail_ind" SMALLINT   ENCODE lzo
	,"recipient_computed_gender_code" SMALLINT   ENCODE lzo
	,"recipient_computed_gender_dscr" VARCHAR(20)   ENCODE lzo
	,"recipient_ecard_opted_ind" SMALLINT   ENCODE lzo
	,"recipient_mbs_acclaim_customer_id" BIGINT   ENCODE lzo
	,"recipient_mbs_pc7_b2b_customer_id" BIGINT   ENCODE lzo
	,"recipient_mbs_pc7_b2c_customer_id" BIGINT   ENCODE lzo
	,"recipient_black_list_postal_mail_reason_cd" VARCHAR(25)   ENCODE lzo
	,"recipient_external_src_cd" VARCHAR(10)   ENCODE lzo
	,"recipient_external_src_dscr" VARCHAR(25)   ENCODE lzo
	,"recipient_src_file_nm" VARCHAR(1020)   ENCODE lzo
	,"recipient_outreach_country_numeric_cd" SMALLINT   ENCODE lzo
	,"recipient_outreach_country_dscr" VARCHAR(100)   ENCODE lzo
	,"recipient_black_list_email_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_black_list_postal_mail_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_external_src_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_external_src_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_last_click_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_last_opened_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_japan_opt_in_cd" SMALLINT   ENCODE lzo
	,"recipient_japan_opt_in_dscr" VARCHAR(25)   ENCODE lzo
	,"outreach_flg" SMALLINT   ENCODE lzo
	,"outreach_dscr" VARCHAR(50)   ENCODE lzo
	,"recipient_external_src_database_nm" VARCHAR(255)   ENCODE lzo
	,"recipient_external_src_database_dscr" VARCHAR(255)   ENCODE lzo
	,"client_level_type_id" SMALLINT   ENCODE lzo
	,"client_level_type_dscr" VARCHAR(50)   ENCODE lzo
	,"country_language_id" SMALLINT   ENCODE lzo
	,"country_language_dscr" VARCHAR(100)   ENCODE lzo
	,"recipient_contact_preference_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_contact_preference_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"data_permission_flag" CHAR(1) ENCODE lzo
	,PRIMARY KEY (customer_key)
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "source_recipient_id"
	, "crm_system_id"
	, "source_system_nm"
	, "ecm_customer_id"
	)
;
--DROP TABLE "edh"."customer_email_contact_task_dim";
CREATE TABLE IF NOT EXISTS "edh"."customer_email_contact_task_dim"
(
	"cust_email_contact_task_key" BIGINT NOT NULL DEFAULT "identity"(471503, 0, '1,1'::text) ENCODE lzo
	,"source_task_key" BIGINT   ENCODE lzo
	,"contact_greeting_type_cd" BIGINT   ENCODE lzo
	,"contact_greeting_type_dscr" VARCHAR(100)   ENCODE lzo
	,"country_language_cd" BIGINT   ENCODE lzo
	,"country_language_dscr" VARCHAR(100)   ENCODE lzo
	,"contact_closing_type_cd" BIGINT   ENCODE lzo
	,"contact_closing_type_dscr" VARCHAR(200)   ENCODE lzo
	,"email_template_nm" VARCHAR(100)   ENCODE lzo
	,"recipient_email_address_txt" VARCHAR(100)   ENCODE lzo
	,"email_subject_txt" VARCHAR(500)   ENCODE lzo
	,"sent_bcc_ind" INTEGER   ENCODE lzo
	,"bcc_email_addresses_txt" VARCHAR(500)   ENCODE lzo
	,"recipient_salutation_txt" VARCHAR(100)   ENCODE lzo
	,"recipient_first_nm" VARCHAR(100)   ENCODE lzo
	,"recipient_last_nm" VARCHAR(100)   ENCODE lzo
	,"email_message_txt" VARCHAR(8000)   ENCODE lzo
	,"employee_nm" VARCHAR(85)   ENCODE lzo
	,"employee_job_title_nm" VARCHAR(100)   ENCODE lzo
	,"employee_email_address_txt" VARCHAR(100)   ENCODE lzo
	,"employee_phone_txt" VARCHAR(30)   ENCODE lzo
	,"contact_task_status_type_cd" BIGINT   ENCODE lzo
	,"contact_task_status_type_dscr" VARCHAR(100)   ENCODE lzo
	,"external_request_id" BIGINT   ENCODE lzo
	,"create_source_id" INTEGER   ENCODE lzo
	,"status_details_txt" VARCHAR(4000)   ENCODE lzo
	,"date_created_tmstmp" VARCHAR(100)   ENCODE lzo
	,"date_last_modified_tmstmp" VARCHAR(100)   ENCODE lzo
	,"ecard_batch_nbr" INTEGER   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (cust_email_contact_task_key)
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."customer_email_dim";
CREATE TABLE IF NOT EXISTS "edh"."customer_email_dim"
(
	"customer_email_key" BIGINT NOT NULL DEFAULT "identity"(394920, 0, '1,1'::text) ENCODE zstd
	,"customer_key" BIGINT   
	,"create_src_system_key" BIGINT   ENCODE lzo
	,"update_src_system_key" BIGINT   ENCODE lzo
	,"adobe_campaign_email_id" BIGINT   ENCODE lzo
	,"ecm_email_id" BIGINT   ENCODE zstd
	,"edw_email_id" BIGINT   ENCODE lzo
	,"email_source_nm" VARCHAR(3)   ENCODE zstd
	,"black_list_ecard_ind" SMALLINT   ENCODE lzo
	,"black_list_email_ind" SMALLINT   ENCODE lzo
	,"src_delete_ind" SMALLINT   ENCODE lzo
	,"primary_ind" SMALLINT   ENCODE zstd
	,"active_ind" SMALLINT   ENCODE zstd
	,"personalize_ind" SMALLINT   ENCODE lzo
	,"email_address_txt" VARCHAR(800)   ENCODE zstd
	,"external_src_database_nm" VARCHAR(1020)   ENCODE lzo
	,"black_list_ecard_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"black_list_email_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"src_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"src_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"opt_out_change_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"email_format_cd" BIGINT   ENCODE lzo
	,"email_format_dscr" VARCHAR(50)   ENCODE lzo
	,"email_type_cd" SMALLINT   ENCODE zstd
	,"email_type_dscr" VARCHAR(100)   ENCODE zstd
	,"active_ind_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"active_ind_create_user_nm" VARCHAR(20)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expire_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (customer_email_key)
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_email_key"
	, "customer_key"
	, "email_address_txt"
	, "email_source_nm"
	)
;
--DROP TABLE "edh"."customer_level_history_fact";
CREATE TABLE IF NOT EXISTS "edh"."customer_level_history_fact"
(
	"customer_key" BIGINT   ENCODE lzo
	,"client_level_id" VARCHAR(4)   ENCODE lzo
	,"client_level_dscr" VARCHAR(50)   ENCODE lzo
	,"source_system_nm" VARCHAR(20)   ENCODE lzo
	,"from_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_current_ind" CHAR(1)   ENCODE lzo
	,"tr_process_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
;
--DROP TABLE "edh"."customer_name_fact";
CREATE TABLE IF NOT EXISTS "edh"."customer_name_fact"
(
	"customer_key" BIGINT NOT NULL  
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"name_id" BIGINT NOT NULL  ENCODE zstd
	,"customer_title_txt" VARCHAR(400)   ENCODE zstd
	,"customer_first_nm" VARCHAR(200)   ENCODE zstd
	,"customer_last_nm" VARCHAR(400)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE KEY
DISTKEY ("customer_key")
SORTKEY (
	"customer_key"
	)
;
--DROP TABLE "edh"."customer_phone_fact";
CREATE TABLE IF NOT EXISTS "edh"."customer_phone_fact"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"create_source_system_key" BIGINT   ENCODE lzo
	,"update_source_system_key" BIGINT   ENCODE lzo
	,"customer_phone_id" BIGINT   ENCODE zstd
	,"phone_type_id" BIGINT   ENCODE zstd
	,"phone_type_dscr" VARCHAR(100)   ENCODE zstd
	,"fraud_type_id" BIGINT   ENCODE zstd
	,"fraud_type_dscr" VARCHAR(100)   ENCODE zstd
	,"phone_nbr" VARCHAR(30)   ENCODE zstd
	,"phone_extension_nbr" VARCHAR(10)   ENCODE zstd
	,"call_priority_nbr" INTEGER   ENCODE zstd
	,"phone_country_iso_cd" VARCHAR(2)   ENCODE zstd
	,"phone_country_iso_nm" VARCHAR(100)   ENCODE zstd
	,"phone_country_display_nm" VARCHAR(100)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"active_ind" SMALLINT   ENCODE zstd
	,"active_indicator_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"active_indicator_update_user_nm" VARCHAR(50)   ENCODE zstd
	,"primary_ind" SMALLINT   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"phone_type_id"
	, "phone_type_dscr"
	)
;
--DROP TABLE "edh"."customer_preferred_interest_fact";
CREATE TABLE IF NOT EXISTS "edh"."customer_preferred_interest_fact"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"customer_preferred_interest_id" BIGINT   ENCODE zstd
	,"interest_type_id" BIGINT   ENCODE zstd
	,"interest_type_dscr" VARCHAR(100)   ENCODE zstd
	,"parent_interest_type_id" BIGINT   ENCODE zstd
	,"parent_interest_type_dscr" VARCHAR(100)   ENCODE zstd
	,"interest_dt" DATE   ENCODE zstd
	,"comment_txt" VARCHAR(16000)   ENCODE zstd
	,"calendar_type_id" SMALLINT   ENCODE zstd
	,"calendar_type_dscr" VARCHAR(100)   ENCODE zstd
	,"value_id" SMALLINT   ENCODE zstd
	,"value_dscr" VARCHAR(25)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_updated_user" VARCHAR(20)   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"interest_type_id"
	, "interest_type_dscr"
	)
;
--DROP TABLE "edh"."customer_visual_analytics";
CREATE TABLE IF NOT EXISTS "edh"."customer_visual_analytics"
(
	"ecm_cust_id" BIGINT   ENCODE lzo
	,"spend_lifetime" NUMERIC(20,5)   ENCODE lzo
	,"gender" VARCHAR(20)   ENCODE lzo
	,"date_of_birth" DOUBLE PRECISION   
	,"age_band" VARCHAR(256)   ENCODE lzo
	,"postal_code" VARCHAR(80)   ENCODE lzo
	,"customer_country" VARCHAR(100)   ENCODE lzo
	,"allow_email" VARCHAR(256)   ENCODE lzo
	,"allow_phone" VARCHAR(256)   ENCODE lzo
	,"allow_mail" VARCHAR(256)   ENCODE lzo
	,"cic_flag" CHAR(12)   ENCODE lzo
	,"first_purchase_date" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"customer_profile" VARCHAR(100)   ENCODE lzo
	,"household_id" INTEGER   ENCODE lzo
	,"householdflag" INTEGER   ENCODE lzo
	,"ecm_active_flag" SMALLINT   ENCODE lzo
	,"we_net_worth" VARCHAR(20)   ENCODE lzo
	,"marital_status" CHAR(20)   ENCODE lzo
	,"household_income" VARCHAR(40)   ENCODE lzo
	,"mb_primary_segment_description" VARCHAR(50)   ENCODE lzo
	,"fin_product_family" VARCHAR(30)   ENCODE lzo
	,"fin_product_subfamily" VARCHAR(30)   ENCODE lzo
	,"department" VARCHAR(256)   ENCODE lzo
	,"financial_product_category" VARCHAR(40)   ENCODE lzo
	,"merch_collection" VARCHAR(25)   ENCODE lzo
	,"product_type" VARCHAR(30)   ENCODE lzo
	,"sku" BIGINT   ENCODE lzo
	,"channel" VARCHAR(25)   ENCODE lzo
	,"location" VARCHAR(40)   ENCODE lzo
	,"mips_store_number" BIGINT   ENCODE lzo
	,"store_country" VARCHAR(100)   ENCODE lzo
	,"global_region" VARCHAR(25)   ENCODE lzo
	,"global_sub_region" VARCHAR(25)   ENCODE lzo
	,"region" VARCHAR(25)   ENCODE lzo
	,"store_city" VARCHAR(25)   ENCODE lzo
	,"store_postal_code" VARCHAR(25)   ENCODE lzo
	,"store_latitude" VARCHAR(256)   ENCODE lzo
	,"store_longitude" VARCHAR(256)   ENCODE lzo
	,"currency_code" VARCHAR(3)   ENCODE lzo
	,"gl_date" DATE   ENCODE lzo
	,"fiscal_year" VARCHAR(6)   ENCODE lzo
	,"fiscal_month" VARCHAR(15)   ENCODE lzo
	,"extended_price_usd" NUMERIC(20,5)   ENCODE lzo
	,"extended_price_lc" NUMERIC(20,5)   ENCODE lzo
	,"total_sales_amount_with_tax_usd" NUMERIC(21,5)   ENCODE lzo
	,"total_sales_amount_with_tax_lc" NUMERIC(21,5)   ENCODE lzo
	,"units" BIGINT   ENCODE lzo
	,"invoice_number" VARCHAR(15)   ENCODE lzo
	,"price_point_usd" NUMERIC(38,23)   ENCODE lzo
	,"price_point_lc" NUMERIC(38,23)   ENCODE lzo
	,"price_point_with_tax_usd" NUMERIC(38,23)   ENCODE lzo
	,"price_point_with_tax_lc" NUMERIC(38,23)   ENCODE lzo
	,"tourism_type" VARCHAR(10)   ENCODE lzo
	,"historical_tr_level" VARCHAR(256)   ENCODE lzo
	,"eng_flag_pos" VARCHAR(256)   ENCODE lzo
	,"registered_customer_flag" INTEGER   ENCODE lzo
	,"transaction_key" INTEGER   ENCODE lzo
	,"return_transaction_key" INTEGER   ENCODE lzo
	,"current_tr_level" VARCHAR(256)   ENCODE lzo
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."date_dim";
CREATE TABLE IF NOT EXISTS "edh"."date_dim"
(
	"date_key" BIGINT NOT NULL  ENCODE zstd
	,"source_date_key" BIGINT NOT NULL  ENCODE zstd
	,"date_yyyy_nbr" SMALLINT   ENCODE lzo
	,"date_month_txt" VARCHAR(15)   ENCODE zstd
	,"date_day_txt" VARCHAR(18)   ENCODE zstd
	,"date_year_454_txt" VARCHAR(18)   ENCODE zstd
	,"date_month_454_txt" VARCHAR(18)   ENCODE zstd
	,"date_week_454_txt" VARCHAR(16)   ENCODE zstd
	,"date_day_of_week_454_txt" VARCHAR(9)   ENCODE zstd
	,"date_fiscal_year_txt" VARCHAR(6)   ENCODE zstd
	,"date_fiscal_month_txt" VARCHAR(15)   ENCODE zstd
	,"date_fiscal_quarter_txt" VARCHAR(15)   ENCODE zstd
	,"date_holiday_season_ind" VARCHAR(1)   ENCODE lzo
	,"date_cymd_nbr" INTEGER   ENCODE lzo
	,"date_cc_nbr" SMALLINT   ENCODE lzo
	,"date_yy_nbr" SMALLINT   ENCODE lzo
	,"date_mm_nbr" SMALLINT   ENCODE lzo
	,"date_dd_nbr" SMALLINT   ENCODE lzo
	,"date_mips_week_454_txt" VARCHAR(16)   ENCODE zstd
	,"date_dt" DATE   
	,"date_julian_calendar_nbr" INTEGER   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (date_key)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"date_dt"
	, "date_key"
	, "date_fiscal_month_txt"
	, "date_fiscal_year_txt"
	)
;
--DROP TABLE "edh"."delivery_dim";
CREATE TABLE IF NOT EXISTS "edh"."delivery_dim"
(
	"delivery_key" BIGINT NOT NULL DEFAULT "identity"(394939, 0, '1,1'::text) ENCODE zstd
	,"source_delivery_id" BIGINT   
	,"delivery_total_amt" NUMERIC(20,5)   ENCODE zstd
	,"delivery_delay_extraction_nbr" NUMERIC(20,5)   ENCODE zstd
	,"delivery_duration_nbr" NUMERIC(20,5)   ENCODE zstd
	,"delivery_retry_period_nbr" NUMERIC(20,5)   ENCODE zstd
	,"delivery_fcp_ind" SMALLINT   ENCODE lzo
	,"delivery_email_attachment_ind" SMALLINT   ENCODE lzo
	,"delivery_delaid_ind" SMALLINT   ENCODE lzo
	,"delivery_built_in_template_ind" SMALLINT   ENCODE lzo
	,"delivery_delete_status_ind" SMALLINT   ENCODE lzo
	,"delivery_message_type_cd" SMALLINT   ENCODE lzo
	,"delivery_message_type_dscr" VARCHAR(20)   ENCODE lzo
	,"delivery_model_ind" SMALLINT   ENCODE lzo
	,"delivery_mirror_page_usage_ind" SMALLINT   ENCODE lzo
	,"delivery_status_cd" SMALLINT   ENCODE lzo
	,"delivery_status_dscr" VARCHAR(50)   ENCODE zstd
	,"delivery_use_budget_validation_ind" SMALLINT   ENCODE lzo
	,"delivery_use_content_validation_ind" SMALLINT   ENCODE lzo
	,"delivery_use_extraction_validation_ind" SMALLINT   ENCODE lzo
	,"delivery_use_fcp_validation_ind" SMALLINT   ENCODE lzo
	,"delivery_use_target_validation_ind" SMALLINT   ENCODE lzo
	,"delivery_online_resource_purged_ind" SMALLINT   ENCODE lzo
	,"delivery_collection_nm" VARCHAR(1020)   ENCODE lzo
	,"delivery_country_cd" VARCHAR(100)   
	,"delivery_country_dscr" VARCHAR(400)   ENCODE lzo
	,"delivery_creative_content_cd" VARCHAR(1020)   ENCODE lzo
	,"delivery_creative_content_dscr" VARCHAR(1020)   ENCODE lzo
	,"delivery_creative_format_cd" VARCHAR(256)   ENCODE lzo
	,"delivery_creative_format_dscr" VARCHAR(256)   ENCODE lzo
	,"delivery_creative_layout_cd" VARCHAR(1020)   ENCODE lzo
	,"delivery_creative_layout_dscr" VARCHAR(1020)   ENCODE lzo
	,"delivery_creative_version_nm" VARCHAR(256)   ENCODE lzo
	,"delivery_cd" VARCHAR(200)   ENCODE lzo
	,"delivery_code_dscr" VARCHAR(200)   ENCODE lzo
	,"delivery_dscr" VARCHAR(2048)   ENCODE zstd
	,"delivery_event_type_cd" VARCHAR(1020)   ENCODE lzo
	,"delivery_event_type_dscr" VARCHAR(1020)   ENCODE lzo
	,"delivery_internal_nm" VARCHAR(400)   ENCODE zstd
	,"delivery_ip_affinity_cd" VARCHAR(100)   ENCODE lzo
	,"delivery_ip_affinity_dscr" VARCHAR(100)   ENCODE lzo
	,"delivery_job_type" VARCHAR(128)   ENCODE lzo
	,"delivery_label_txt" VARCHAR(512)   ENCODE zstd
	,"delivery_media_type" VARCHAR(1020)   ENCODE lzo
	,"delivery_nature_nm" VARCHAR(256)   
	,"delivery_product_type" VARCHAR(1020)   ENCODE lzo
	,"delivery_promotion_period_txt" VARCHAR(256)   ENCODE lzo
	,"delivery_promotion_theme_txt" VARCHAR(1020)   ENCODE lzo
	,"delivery_utm_campaign_nm" VARCHAR(160)   ENCODE lzo
	,"delivery_utm_campaign_medium_nm" VARCHAR(96)   ENCODE lzo
	,"delivery_utm_campaign_content_txt" VARCHAR(96)   ENCODE lzo
	,"delivery_utm_campaign_src_nm" VARCHAR(96)   ENCODE lzo
	,"delivery_validation_mode_cd" VARCHAR(100)   ENCODE lzo
	,"delivery_validation_mode_dscr" VARCHAR(100)   ENCODE lzo
	,"delivery_broad_start_tmstmp" TIMESTAMP WITHOUT TIME ZONE   
	,"delivery_broad_end_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_contact_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_content_modification_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_content_approval_deadline_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_extraction_file_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_tracked_from_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_tracked_to_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_source_proofed_delivery_id" BIGINT   ENCODE lzo
	,"delivery_processed_cnt" BIGINT   ENCODE lzo
	,"source_operation_id" BIGINT   ENCODE zstd
	,"operation_builin_ind" SMALLINT   ENCODE lzo
	,"operation_job_template_ind" SMALLINT   ENCODE lzo
	,"operation_use_budget_ind" SMALLINT   ENCODE lzo
	,"operation_use_budget_validation_ind" SMALLINT   ENCODE lzo
	,"operation_use_content_validation_ind" SMALLINT   ENCODE lzo
	,"operation_use_extraction_validation_ind" SMALLINT   ENCODE lzo
	,"operation_country_nm" VARCHAR(80)   
	,"operation_country_dscr" VARCHAR(400)   ENCODE zstd
	,"operation_internal_nm" VARCHAR(256)   ENCODE zstd
	,"operation_label_txt" VARCHAR(512)   ENCODE zstd
	,"operation_start_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"operation_end_tmstmp" TIMESTAMP WITHOUT TIME ZONE   
	,"operation_last_computed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"operation_budget_status_cd" SMALLINT   ENCODE lzo
	,"operation_budget_status_dscr" VARCHAR(20)   ENCODE zstd
	,"operation_cancel_state_cd" SMALLINT   ENCODE lzo
	,"operation_cancel_state_dscr" VARCHAR(20)   ENCODE zstd
	,"operation_commitment_level_cd" SMALLINT   ENCODE lzo
	,"operation_commitment_level_dscr" VARCHAR(25)   ENCODE zstd
	,"operation_complexity_cd" SMALLINT   ENCODE lzo
	,"operation_complexity_dscr" VARCHAR(25)   ENCODE zstd
	,"operation_computation_state_cd" SMALLINT   ENCODE lzo
	,"operation_computation_state_dscr" VARCHAR(25)   ENCODE zstd
	,"operation_message_type_cd" SMALLINT   ENCODE lzo
	,"operation_message_type_dscr" VARCHAR(50)   ENCODE zstd
	,"operation_nature_nm" VARCHAR(256)   ENCODE lzo
	,"operation_nature_dscr" VARCHAR(256)   ENCODE lzo
	,"operation_type_cd" SMALLINT   ENCODE lzo
	,"operation_type_dscr" VARCHAR(15)   ENCODE zstd
	,"operation_validation_mode_cd" SMALLINT   ENCODE lzo
	,"operation_validation_mode_dscr" VARCHAR(50)   ENCODE zstd
	,"operation_sandbox_mode_cd" SMALLINT   ENCODE lzo
	,"operation_sandbox_mode_dscr" VARCHAR(100)   ENCODE zstd
	,"operation_occasion_nm" VARCHAR(100)   ENCODE lzo
	,"operation_occasion_dscr" VARCHAR(100)   ENCODE lzo
	,"operation_theme_nm" VARCHAR(100)   ENCODE lzo
	,"operation_theme_dscr" VARCHAR(100)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (delivery_key)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"source_delivery_id"
	, "operation_end_tmstmp"
	, "delivery_broad_start_tmstmp"
	, "delivery_country_cd"
	, "delivery_label_txt"
	, "delivery_nature_nm"
	, "operation_country_nm"
	, "mapping_nm"
	)
;
--DROP TABLE "edh"."delivery_response_aggr";
CREATE TABLE IF NOT EXISTS "edh"."delivery_response_aggr"
(
	"delivery_response_aggr_id" BIGINT NOT NULL DEFAULT "identity"(394944, 0, '1,1'::text) 
	,"source_type" VARCHAR(10)   
	,"source_nm" VARCHAR(15)   
	,"metric_type" VARCHAR(15)   
	,"source_operation_id" BIGINT   ENCODE lzo
	,"source_delivery_id" BIGINT   
	,"delivery_segment_cd" VARCHAR(200)   
	,"ip_affinity_cd" SMALLINT   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"total_sent_cnt" INTEGER   ENCODE lzo
	,"total_hard_bounce_cnt" INTEGER   ENCODE lzo
	,"total_soft_bounce_cnt" INTEGER   ENCODE lzo
	,"total_complaint_cnt" INTEGER   ENCODE lzo
	,"total_delivered_cnt" INTEGER   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"total_unique_open_cnt" INTEGER   ENCODE lzo
	,"total_unique_click_cnt" INTEGER   ENCODE lzo
	,"total_unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"total_orders_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_in_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_in_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"source_channel_key" BIGINT   
	,"source_product_key" BIGINT   
	,"attribution_type" VARCHAR(15)   ENCODE lzo
	,"total_direct_attribution_orders_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_in_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_in_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_orders_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_in_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_in_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"mbv_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mbv_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_source_delivery_id" BIGINT   ENCODE lzo
	,"delivery_source_operation_id" BIGINT   ENCODE lzo
	,"delivery_label_txt" VARCHAR(512)   ENCODE lzo
	,"delivery_message_type_cd" SMALLINT   ENCODE lzo
	,"delivery_broad_start_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"delivery_cd" VARCHAR(200)   ENCODE lzo
	,"delivery_country_cd" VARCHAR(100)   ENCODE lzo
	,"delivery_promotion_period_nm" VARCHAR(256)   ENCODE lzo
	,"delivery_creative_format_nm" VARCHAR(256)   ENCODE lzo
	,"delivery_creative_version_nm" VARCHAR(256)   ENCODE lzo
	,"delivery_iso_2_char_country_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_has_control_ind" INTEGER   ENCODE lzo
	,"delivery_has_treated_ind" INTEGER   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"market_iso_2_char_country_cd" VARCHAR(2)   ENCODE lzo
	,"market_iso_3_char_country_cd" VARCHAR(3)   ENCODE lzo
	,"market_iso_numeric_country_cd" SMALLINT   ENCODE lzo
	,"market_iso_3_cd" SMALLINT   ENCODE lzo
	,"market_english_label_txt" VARCHAR(80)   ENCODE lzo
	,"market_local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"market_region_nm" VARCHAR(25)   ENCODE lzo
	,"operation_source_operation_id" BIGINT   ENCODE lzo
	,"operation_message_type_cd" SMALLINT   ENCODE lzo
	,"operation_label_txt" VARCHAR(512)   ENCODE lzo
	,"operation_nature_nm" VARCHAR(256)   ENCODE lzo
	,"operation_control_end_date_key" BIGINT   ENCODE lzo
	,"date_date_key" BIGINT   ENCODE lzo
	,"date_date_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"date_date_dt" DATE   ENCODE lzo
	,"epd_currency_cd" VARCHAR(3)   ENCODE lzo
	,"epd_currency_nm" VARCHAR(100)   ENCODE lzo
	,"epd_currency_symbol" VARCHAR(40)   ENCODE lzo
	,"epd_unidec01_nbr" SMALLINT   ENCODE lzo
	,"epd_unidec02_nbr" SMALLINT   ENCODE lzo
	,"epd_unidec03_nbr" SMALLINT   ENCODE lzo
	,"epd_unidec04_nbr" SMALLINT   ENCODE lzo
	,"epd_unihex01_nbr" VARCHAR(80)   ENCODE lzo
	,"epd_unihex02_nbr" VARCHAR(80)   ENCODE lzo
	,"epd_unihex03_nbr" VARCHAR(80)   ENCODE lzo
	,"epd_unihex04_nbr" VARCHAR(80)   ENCODE lzo
	,"ipaffinity_ip_affinity_cd" SMALLINT   ENCODE lzo
	,"ipaffinity_ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"channel_source_channel_key" BIGINT   ENCODE lzo
	,"channel_display_country_nm" VARCHAR(100)   ENCODE lzo
	,"channel_currency_cd" VARCHAR(25)   ENCODE lzo
	,"channel_business_type" VARCHAR(50)   ENCODE lzo
	,"channel_unified_channel_nm" VARCHAR(25)   ENCODE lzo
	,"channel_sub_channel_nm" VARCHAR(25)   ENCODE lzo
	,"channel_include_channel_ind" SMALLINT   ENCODE lzo
	,"channel_retail_channel_ind" SMALLINT   ENCODE lzo
	,"product_source_product_key" BIGINT   ENCODE lzo
	,"product_financial_product_family_nm" VARCHAR(50)   ENCODE lzo
	,"product_financial_product_sub_family_nm" VARCHAR(50)   ENCODE lzo
	,"product_epd_revised_merchandise_collection_nm" VARCHAR(50)   ENCODE lzo
	,"product_epd_product_type_tier_2_nm" VARCHAR(50)   ENCODE lzo
	,"product_class_dscr" VARCHAR(100)   ENCODE lzo
	,"product_department_dscr" VARCHAR(100)   ENCODE lzo
	,"product_include_units_ind" SMALLINT   ENCODE lzo
	,"deliverysegment_delivery_id" BIGINT   ENCODE lzo
	,"deliverysegment_segment_cd" VARCHAR(50)   ENCODE lzo
	,"deliverysegment_control_ind" SMALLINT   ENCODE lzo
	,"deliverysegment_treated_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY (
	"source_delivery_id"
	, "source_channel_key"
	, "source_product_key"
	, "source_type"
	, "metric_type"
	, "delivery_response_aggr_id"
	, "source_nm"
	, "delivery_segment_cd"
	)
;
--DROP TABLE "edh"."delivery_segment_dim";
CREATE TABLE IF NOT EXISTS "edh"."delivery_segment_dim"
(
	"delivery_segment_key" BIGINT NOT NULL DEFAULT "identity"(394947, 0, '1,1'::text) ENCODE lzo
	,"delivery_id" BIGINT   
	,"delivery_segment_cd" VARCHAR(50)   
	,"control_ind" SMALLINT   ENCODE lzo
	,"treated_ind" SMALLINT   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (delivery_segment_key)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"delivery_id"
	, "delivery_segment_cd"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact"
(
	"sl_unique_key" BIGINT   ENCODE mostly32
	,"source_customer_key" BIGINT   ENCODE lzo
	,"source_channel_key" BIGINT   ENCODE lzo
	,"source_product_key" BIGINT   ENCODE lzo
	,"invoice_date_key" BIGINT   ENCODE delta32k
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE bytedict
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE bytedict
	,"has_units_ind" INTEGER   ENCODE lzo
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_03032018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_03032018a"
(
	"sl_unique_key" BIGINT   ENCODE lzo
	,"source_customer_key" BIGINT   
	,"source_channel_key" BIGINT   
	,"source_product_key" BIGINT   
	,"invoice_date_key" BIGINT   ENCODE lzo
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"has_units_ind" INTEGER   
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_03102018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_03102018a"
(
	"sl_unique_key" BIGINT   ENCODE lzo
	,"source_customer_key" BIGINT   
	,"source_channel_key" BIGINT   
	,"source_product_key" BIGINT   
	,"invoice_date_key" BIGINT   ENCODE lzo
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"has_units_ind" INTEGER   
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_03242018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_03242018a"
(
	"sl_unique_key" BIGINT   ENCODE lzo
	,"source_customer_key" BIGINT   
	,"source_channel_key" BIGINT   
	,"source_product_key" BIGINT   
	,"invoice_date_key" BIGINT   ENCODE lzo
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"has_units_ind" INTEGER   
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_03312018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_03312018a"
(
	"sl_unique_key" BIGINT   ENCODE lzo
	,"source_customer_key" BIGINT   
	,"source_channel_key" BIGINT   
	,"source_product_key" BIGINT   
	,"invoice_date_key" BIGINT   ENCODE lzo
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"has_units_ind" INTEGER   
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_04072018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_04072018a"
(
	"sl_unique_key" BIGINT   ENCODE mostly32
	,"source_customer_key" BIGINT   ENCODE lzo
	,"source_channel_key" BIGINT   ENCODE lzo
	,"source_product_key" BIGINT   ENCODE lzo
	,"invoice_date_key" BIGINT   ENCODE delta32k
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE bytedict
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE bytedict
	,"has_units_ind" INTEGER   ENCODE lzo
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_04142018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_04142018a"
(
	"sl_unique_key" BIGINT   ENCODE mostly32
	,"source_customer_key" BIGINT   ENCODE lzo
	,"source_channel_key" BIGINT   ENCODE lzo
	,"source_product_key" BIGINT   ENCODE lzo
	,"invoice_date_key" BIGINT   ENCODE delta32k
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE bytedict
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE bytedict
	,"has_units_ind" INTEGER   ENCODE lzo
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_04212018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_04212018a"
(
	"sl_unique_key" BIGINT   ENCODE mostly32
	,"source_customer_key" BIGINT   ENCODE lzo
	,"source_channel_key" BIGINT   ENCODE lzo
	,"source_product_key" BIGINT   ENCODE lzo
	,"invoice_date_key" BIGINT   ENCODE delta32k
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE bytedict
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE bytedict
	,"has_units_ind" INTEGER   ENCODE lzo
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_04282018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_04282018a"
(
	"sl_unique_key" BIGINT   ENCODE mostly32
	,"source_customer_key" BIGINT   ENCODE lzo
	,"source_channel_key" BIGINT   ENCODE lzo
	,"source_product_key" BIGINT   ENCODE lzo
	,"invoice_date_key" BIGINT   ENCODE delta32k
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE bytedict
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE bytedict
	,"has_units_ind" INTEGER   ENCODE lzo
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_05052018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_05052018a"
(
	"sl_unique_key" BIGINT   ENCODE mostly32
	,"source_customer_key" BIGINT   ENCODE lzo
	,"source_channel_key" BIGINT   ENCODE lzo
	,"source_product_key" BIGINT   ENCODE lzo
	,"invoice_date_key" BIGINT   ENCODE delta32k
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE bytedict
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE bytedict
	,"has_units_ind" INTEGER   ENCODE lzo
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_05122018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_05122018a"
(
	"sl_unique_key" BIGINT   ENCODE mostly32
	,"source_customer_key" BIGINT   ENCODE lzo
	,"source_channel_key" BIGINT   ENCODE lzo
	,"source_product_key" BIGINT   ENCODE lzo
	,"invoice_date_key" BIGINT   ENCODE delta32k
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE bytedict
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE bytedict
	,"has_units_ind" INTEGER   ENCODE lzo
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_05192018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_05192018a"
(
	"sl_unique_key" BIGINT   ENCODE mostly32
	,"source_customer_key" BIGINT   ENCODE lzo
	,"source_channel_key" BIGINT   ENCODE lzo
	,"source_product_key" BIGINT   ENCODE lzo
	,"invoice_date_key" BIGINT   ENCODE delta32k
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE bytedict
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE bytedict
	,"has_units_ind" INTEGER   ENCODE lzo
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."dwpsaleh_email_delivery_fact_05262018a";
CREATE TABLE IF NOT EXISTS "edh"."dwpsaleh_email_delivery_fact_05262018a"
(
	"sl_unique_key" BIGINT   ENCODE mostly32
	,"source_customer_key" BIGINT   ENCODE lzo
	,"source_channel_key" BIGINT   ENCODE lzo
	,"source_product_key" BIGINT   ENCODE lzo
	,"invoice_date_key" BIGINT   ENCODE delta32k
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"number_of_units_qty" BIGINT   ENCODE lzo
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE bytedict
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE bytedict
	,"has_units_ind" INTEGER   ENCODE lzo
	,"to_sinv_processed_ind" SMALLINT   ENCODE lzo
	,"to_sinv_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."edh_source_system_dim";
CREATE TABLE IF NOT EXISTS "edh"."edh_source_system_dim"
(
	"source_system_key" BIGINT NOT NULL  
	,"source_system_short_dscr" VARCHAR(50) NOT NULL  
	,"source_system_long_dscr" VARCHAR(100) NOT NULL  ENCODE lzo
	,"region" VARCHAR(50)   
	,"instance" VARCHAR(100)   ENCODE lzo
	,"function" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
SORTKEY (
	"source_system_key"
	, "source_system_short_dscr"
	, "region"
	)
;
--DROP TABLE "edh"."email_delivery_fact";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact"
(
	"customer_key" BIGINT   ENCODE mostly32
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE mostly32
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   ENCODE mostly32
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE mostly32
	,"ecm_customer_id" BIGINT   ENCODE mostly32
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE delta
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE bytedict
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE delta32k
	,"delivery_tracked_to_date_key" BIGINT   ENCODE delta32k
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE delta32k
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE delta32k
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE delta32k
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE delta32k
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE delta32k
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_03032018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_03032018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   
	,"market_key" BIGINT   
	,"epd_currency_key" BIGINT   
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE lzo
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE lzo
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_03102018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_03102018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   
	,"market_key" BIGINT   
	,"epd_currency_key" BIGINT   
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE lzo
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE lzo
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_03242018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_03242018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   
	,"market_key" BIGINT   
	,"epd_currency_key" BIGINT   
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE lzo
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE lzo
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_03312018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_03312018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   
	,"market_key" BIGINT   
	,"epd_currency_key" BIGINT   
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE lzo
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE lzo
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_04072018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_04072018a"
(
	"customer_key" BIGINT   ENCODE mostly32
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE mostly32
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   ENCODE mostly32
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE mostly32
	,"ecm_customer_id" BIGINT   ENCODE mostly32
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE delta
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE bytedict
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE delta32k
	,"delivery_tracked_to_date_key" BIGINT   ENCODE delta32k
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE delta32k
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE delta32k
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE delta32k
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE delta32k
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE delta32k
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_04142018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_04142018a"
(
	"customer_key" BIGINT   ENCODE mostly32
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE mostly32
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   ENCODE mostly32
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE mostly32
	,"ecm_customer_id" BIGINT   ENCODE mostly32
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE delta
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE bytedict
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE delta32k
	,"delivery_tracked_to_date_key" BIGINT   ENCODE delta32k
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE delta32k
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE delta32k
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE delta32k
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE delta32k
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE delta32k
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_04212018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_04212018a"
(
	"customer_key" BIGINT   ENCODE mostly32
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE mostly32
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   ENCODE mostly32
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE mostly32
	,"ecm_customer_id" BIGINT   ENCODE mostly32
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE delta
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE bytedict
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE delta32k
	,"delivery_tracked_to_date_key" BIGINT   ENCODE delta32k
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE delta32k
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE delta32k
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE delta32k
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE delta32k
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE delta32k
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_04282018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_04282018a"
(
	"customer_key" BIGINT   ENCODE mostly32
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE mostly32
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   ENCODE mostly32
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE mostly32
	,"ecm_customer_id" BIGINT   ENCODE mostly32
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE delta
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE bytedict
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE delta32k
	,"delivery_tracked_to_date_key" BIGINT   ENCODE delta32k
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE delta32k
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE delta32k
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE delta32k
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE delta32k
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE delta32k
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_05052018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_05052018a"
(
	"customer_key" BIGINT   ENCODE mostly32
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE mostly32
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   ENCODE mostly32
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE mostly32
	,"ecm_customer_id" BIGINT   ENCODE mostly32
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE delta
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE bytedict
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE delta32k
	,"delivery_tracked_to_date_key" BIGINT   ENCODE delta32k
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE delta32k
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE delta32k
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE delta32k
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE delta32k
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE delta32k
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_05122018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_05122018a"
(
	"customer_key" BIGINT   ENCODE mostly32
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE mostly32
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   ENCODE mostly32
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE mostly32
	,"ecm_customer_id" BIGINT   ENCODE mostly32
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE delta
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE bytedict
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE delta32k
	,"delivery_tracked_to_date_key" BIGINT   ENCODE delta32k
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE delta32k
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE delta32k
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE delta32k
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE delta32k
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE delta32k
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_05192018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_05192018a"
(
	"customer_key" BIGINT   ENCODE mostly32
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE mostly32
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   ENCODE mostly32
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE mostly32
	,"ecm_customer_id" BIGINT   ENCODE mostly32
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE delta
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE bytedict
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE delta32k
	,"delivery_tracked_to_date_key" BIGINT   ENCODE delta32k
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE delta32k
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE delta32k
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE delta32k
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE delta32k
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE delta32k
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_delivery_fact_05262018a";
CREATE TABLE IF NOT EXISTS "edh"."email_delivery_fact_05262018a"
(
	"customer_key" BIGINT   ENCODE mostly32
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE mostly32
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   ENCODE mostly32
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE mostly32
	,"ecm_customer_id" BIGINT   ENCODE mostly32
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE delta
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE bytedict
	,"mb_primary_segment_cd" VARCHAR(2)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE delta32k
	,"delivery_tracked_to_date_key" BIGINT   ENCODE delta32k
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE delta32k
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE delta32k
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE delta32k
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"first_open_date_key" BIGINT   ENCODE delta32k
	,"first_click_date_key" BIGINT   ENCODE lzo
	,"first_opt_out_date_key" BIGINT   ENCODE lzo
	,"last_open_date_key" BIGINT   ENCODE delta32k
	,"last_click_date_key" BIGINT   ENCODE lzo
	,"last_opt_out_date_key" BIGINT   ENCODE lzo
	,"total_open_cnt" INTEGER   ENCODE lzo
	,"total_click_cnt" INTEGER   ENCODE lzo
	,"total_opt_out_cnt" INTEGER   ENCODE lzo
	,"unique_open_cnt" INTEGER   ENCODE lzo
	,"unique_click_cnt" INTEGER   ENCODE lzo
	,"unique_opt_out_cnt" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_response_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_conversion_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_open_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_click_qty" INTEGER   ENCODE lzo
	,"days_between_delivery_and_first_opt_out_qty" INTEGER   ENCODE lzo
	,"total_order_cnt" INTEGER   ENCODE lzo
	,"total_units_cnt" INTEGER   ENCODE lzo
	,"total_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_direct_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_direct_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_order_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_units_cnt" INTEGER   ENCODE lzo
	,"total_inferred_attribution_revenue_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"total_inferred_attribution_revenue_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(10)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "delivery_key"
	, "customer_email_key"
	, "delivery_segment_key"
	, "market_key"
	, "epd_currency_key"
	, "broad_log_id"
	, "recipient_id"
	)
;
--DROP TABLE "edh"."email_tracking_fact";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_tracked_from_dt" DATE   ENCODE lzo
	,"delivery_tracked_to_dt" DATE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"updated_by_load_sequence_ind" SMALLINT   ENCODE lzo
	,"delivery_has_control_ind" SMALLINT   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "customer_key"
	, "delivery_key"
	, "customer_email_key"
	)
;
--DROP TABLE "edh"."email_tracking_fact_03032018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_03032018a"
(
	"customer_key" BIGINT   ENCODE lzo
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE lzo
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_broad_start_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_broad_end_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "delivery_is_report_ind"
	)
;
--DROP TABLE "edh"."email_tracking_fact_03102018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_03102018a"
(
	"customer_key" BIGINT   ENCODE lzo
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE lzo
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_broad_start_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_broad_end_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "delivery_is_report_ind"
	)
;
--DROP TABLE "edh"."email_tracking_fact_03242018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_03242018a"
(
	"customer_key" BIGINT   ENCODE lzo
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE lzo
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_broad_start_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_broad_end_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "delivery_is_report_ind"
	)
;
--DROP TABLE "edh"."email_tracking_fact_03312018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_03312018a"
(
	"customer_key" BIGINT   ENCODE lzo
	,"delivery_key" BIGINT   ENCODE lzo
	,"customer_email_key" BIGINT   ENCODE lzo
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_broad_start_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_broad_end_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "delivery_is_report_ind"
	)
;
--DROP TABLE "edh"."email_tracking_fact_04072018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_04072018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_tracked_from_dt" DATE   ENCODE lzo
	,"delivery_tracked_to_dt" DATE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"updated_by_load_sequence_ind" SMALLINT   ENCODE lzo
	,"delivery_has_control_ind" SMALLINT   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "customer_key"
	, "delivery_key"
	, "customer_email_key"
	)
;
--DROP TABLE "edh"."email_tracking_fact_04142018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_04142018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_tracked_from_dt" DATE   ENCODE lzo
	,"delivery_tracked_to_dt" DATE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"updated_by_load_sequence_ind" SMALLINT   ENCODE lzo
	,"delivery_has_control_ind" SMALLINT   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "customer_key"
	, "delivery_key"
	, "customer_email_key"
	)
;
--DROP TABLE "edh"."email_tracking_fact_04212018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_04212018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_tracked_from_dt" DATE   ENCODE lzo
	,"delivery_tracked_to_dt" DATE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"updated_by_load_sequence_ind" SMALLINT   ENCODE lzo
	,"delivery_has_control_ind" SMALLINT   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "customer_key"
	, "delivery_key"
	, "customer_email_key"
	)
;
--DROP TABLE "edh"."email_tracking_fact_04282018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_04282018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_tracked_from_dt" DATE   ENCODE lzo
	,"delivery_tracked_to_dt" DATE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"updated_by_load_sequence_ind" SMALLINT   ENCODE lzo
	,"delivery_has_control_ind" SMALLINT   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "customer_key"
	, "delivery_key"
	, "customer_email_key"
	)
;
--DROP TABLE "edh"."email_tracking_fact_05052018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_05052018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_tracked_from_dt" DATE   ENCODE lzo
	,"delivery_tracked_to_dt" DATE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"updated_by_load_sequence_ind" SMALLINT   ENCODE lzo
	,"delivery_has_control_ind" SMALLINT   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "customer_key"
	, "delivery_key"
	, "customer_email_key"
	)
;
--DROP TABLE "edh"."email_tracking_fact_05122018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_05122018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_tracked_from_dt" DATE   ENCODE lzo
	,"delivery_tracked_to_dt" DATE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"updated_by_load_sequence_ind" SMALLINT   ENCODE lzo
	,"delivery_has_control_ind" SMALLINT   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "customer_key"
	, "delivery_key"
	, "customer_email_key"
	)
;
--DROP TABLE "edh"."email_tracking_fact_05192018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_05192018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_tracked_from_dt" DATE   ENCODE lzo
	,"delivery_tracked_to_dt" DATE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"updated_by_load_sequence_ind" SMALLINT   ENCODE lzo
	,"delivery_has_control_ind" SMALLINT   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "customer_key"
	, "delivery_key"
	, "customer_email_key"
	)
;
--DROP TABLE "edh"."email_tracking_fact_05262018a";
CREATE TABLE IF NOT EXISTS "edh"."email_tracking_fact_05262018a"
(
	"customer_key" BIGINT   
	,"delivery_key" BIGINT   
	,"customer_email_key" BIGINT   
	,"delivery_segment_key" BIGINT   ENCODE lzo
	,"market_key" BIGINT   ENCODE lzo
	,"epd_currency_key" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"delivery_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"email_domain_nm" VARCHAR(400)   ENCODE lzo
	,"segment_cd" VARCHAR(200)   ENCODE lzo
	,"ip_affinity_cd" INTEGER   ENCODE lzo
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"mb_primary_segment_cd" VARCHAR(5)   ENCODE lzo
	,"mb_primary_segment_dscr" VARCHAR(50)   ENCODE lzo
	,"message_id" BIGINT   ENCODE lzo
	,"flag_cd" INTEGER   ENCODE lzo
	,"service_id" BIGINT   ENCODE lzo
	,"status_cd" INTEGER   ENCODE lzo
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"sent_cnt" INTEGER   ENCODE lzo
	,"hard_bounce_cnt" INTEGER   ENCODE lzo
	,"soft_bounce_cnt" INTEGER   ENCODE lzo
	,"complaint_cnt" INTEGER   ENCODE lzo
	,"delivered_cnt" INTEGER   ENCODE lzo
	,"sent_date_key" BIGINT   ENCODE lzo
	,"complaint_date_key" BIGINT   ENCODE lzo
	,"bounced_date_key" BIGINT   ENCODE lzo
	,"delivered_date_key" BIGINT   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"delivery_country_nm" VARCHAR(25)   ENCODE lzo
	,"delivery_country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"delivery_tracked_from_dt" DATE   ENCODE lzo
	,"delivery_tracked_to_dt" DATE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"tracking_log_id" BIGINT   
	,"url_id" BIGINT   ENCODE lzo
	,"type_ind" SMALLINT   ENCODE lzo
	,"user_agent_cd" BIGINT   ENCODE lzo
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_type_txt" VARCHAR(64)   ENCODE lzo
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"log_date_key" BIGINT   ENCODE lzo
	,"open_cnt" INTEGER   ENCODE lzo
	,"click_cnt" INTEGER   ENCODE lzo
	,"opt_out_cnt" INTEGER   ENCODE lzo
	,"open_date_key" BIGINT   ENCODE lzo
	,"click_date_key" BIGINT   ENCODE lzo
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"web_tracking_log_id" BIGINT   
	,"visitor_id" BIGINT   ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_units_cnt" INTEGER   ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"direct_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"load_sequence_ind" SMALLINT   
	,"load_sequence_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"email_is_valid_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"updated_by_load_sequence_ind" SMALLINT   ENCODE lzo
	,"delivery_has_control_ind" SMALLINT   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_log_id"
	, "web_tracking_log_id"
	, "load_sequence_ind"
	, "to_edf_processed_ind"
	, "customer_key"
	, "delivery_key"
	, "customer_email_key"
	)
;
--DROP TABLE "edh"."epd_currency_dim";
CREATE TABLE IF NOT EXISTS "edh"."epd_currency_dim"
(
	"epd_currency_key" BIGINT NOT NULL DEFAULT "identity"(394962, 0, '1,1'::text) ENCODE lzo
	,"currency_cd" VARCHAR(3)   
	,"currency_nm" VARCHAR(100)   ENCODE lzo
	,"currency_symbol_txt" VARCHAR(40)   ENCODE lzo
	,"unidec01_nbr" SMALLINT   ENCODE lzo
	,"unidec02_nbr" SMALLINT   ENCODE lzo
	,"unidec03_nbr" SMALLINT   ENCODE lzo
	,"unidec04_nbr" SMALLINT   ENCODE lzo
	,"unihex01_nbr" VARCHAR(80)   ENCODE lzo
	,"unihex02_nbr" VARCHAR(80)   ENCODE lzo
	,"unihex03_nbr" VARCHAR(80)   ENCODE lzo
	,"unihex04_nbr" VARCHAR(80)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expire_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (epd_currency_key)
)
DISTSTYLE ALL
SORTKEY (
	"currency_cd"
	)
;
--DROP TABLE "edh"."experian_aus_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."experian_aus_customer_dim"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"mosaic_group_nm" VARCHAR(255)   ENCODE zstd
	,"mosaic_type_group_cd" VARCHAR(20)   ENCODE bytedict
	,"mosaic_type_group_dscr" VARCHAR(255)   ENCODE zstd
	,"age_cd" VARCHAR(20)   ENCODE zstd
	,"age_cd_dscr" VARCHAR(255)   ENCODE zstd
	,"household_income_cd" VARCHAR(25)   ENCODE zstd
	,"household_income_cd_dscr" VARCHAR(25)   ENCODE bytedict
	,"children_aged_0_11_qty" SMALLINT   ENCODE lzo
	,"children_aged_11_18_qty" SMALLINT   ENCODE lzo
	,"household_relationship_group_cd" VARCHAR(20)   ENCODE zstd
	,"household_relationship_group_cd_dscr" VARCHAR(255)   ENCODE zstd
	,"gender_dscr" VARCHAR(20)   ENCODE zstd
	,"occupation_dscr" VARCHAR(255)   ENCODE zstd
	,"model_generated_decimal_nbr" NUMERIC(20,5)   ENCODE zstd
	,"model_generated_decimal_val" NUMERIC(10,6)   ENCODE bytedict
	,"factor_4_wealth_score_nbr" BIGINT   ENCODE mostly16
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (customer_key)
)
DISTSTYLE KEY
DISTKEY ("customer_key")
SORTKEY (
	"ecm_customer_id"
	)
;
--DROP TABLE "edh"."experian_uk_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."experian_uk_customer_dim"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"gender_cd" VARCHAR(1)   ENCODE zstd
	,"gender_dscr" VARCHAR(15)   ENCODE zstd
	,"person_age_line_cd" VARCHAR(2)   ENCODE zstd
	,"person_age_line_dscr" VARCHAR(15)   ENCODE zstd
	,"household_income_band_cd" CHAR(1)   ENCODE zstd
	,"household_income_band_dscr" VARCHAR(40)   ENCODE zstd
	,"net_worth_level_cd" VARCHAR(1)   ENCODE zstd
	,"net_worth_level_dscr" VARCHAR(15)   ENCODE zstd
	,"marital_status_cd" CHAR(25)   ENCODE zstd
	,"marital_status_dscr" VARCHAR(20)   ENCODE zstd
	,"person_mosaic_shopper_type_cd" CHAR(3)   ENCODE zstd
	,"person_mosaic_shopper_type_dscr" VARCHAR(25)   ENCODE bytedict
	,"household_mosaic_uk_6_group_cd" CHAR(1)   ENCODE zstd
	,"household_mosaic_uk_6_group_dscr" VARCHAR(50)   ENCODE zstd
	,"household_mosaic_uk_6_type_cd" CHAR(2)   ENCODE zstd
	,"household_mosaic_uk_6_type_dscr" VARCHAR(50)   ENCODE zstd
	,"postcard_mosaic_uk_6_group_cd" CHAR(1)   ENCODE zstd
	,"postcard_mosaic_uk_6_group_dscr" VARCHAR(50)   ENCODE zstd
	,"postcard_mosaic_uk_6_type_cd" CHAR(2)   ENCODE zstd
	,"postcard_mosaic_uk_6_type_dscr" VARCHAR(50)   ENCODE zstd
	,"experian_person_key" NUMERIC(10,0)   ENCODE lzo
	,"experian_household_key" NUMERIC(19,0)   ENCODE lzo
	,"new_age_band" VARCHAR(20)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (customer_key)
)
DISTSTYLE KEY
DISTKEY ("customer_key")
SORTKEY (
	"ecm_customer_id"
	)
;
--DROP TABLE "edh"."inv_balance_fact";
CREATE TABLE IF NOT EXISTS "edh"."inv_balance_fact"
(
	"oh_qty_amt" NUMERIC(20,5)   ENCODE lzo
	,"product_key" BIGINT NOT NULL  
	,"channel_key" BIGINT NOT NULL  
	,"inv_location_key" BIGINT NOT NULL  
	,"inv_balance_dt_key" BIGINT NOT NULL  
	,"source_system_key" BIGINT NOT NULL  
	,"itm_rtl_price_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_rtl_price_usd" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_usd" NUMERIC(20,5)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"supply_type" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (product_key, channel_key, inv_location_key, inv_balance_dt_key, source_system_key)
)
DISTSTYLE EVEN
SORTKEY (
	"inv_balance_dt_key"
	, "product_key"
	, "channel_key"
	, "inv_location_key"
	, "source_system_key"
	)
;
--DROP TABLE "edh"."inv_location_dim";
CREATE TABLE IF NOT EXISTS "edh"."inv_location_dim"
(
	"inv_location_key" BIGINT NOT NULL  
	,"inv_location_dscr" CHAR(20) NOT NULL  
	,"src_inv_location_key" BIGINT   ENCODE lzo
	,"saleable_ind" CHAR(1)   ENCODE lzo
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (inv_location_key)
)
DISTSTYLE ALL
SORTKEY (
	"inv_location_key"
	, "inv_location_dscr"
	)
;
--DROP TABLE "edh"."inv_recn_jdee1_to_geo_aggr";
CREATE TABLE IF NOT EXISTS "edh"."inv_recn_jdee1_to_geo_aggr"
(
	"jdee1_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"geo_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_geo_var_age" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_geo_var_qty" NUMERIC(20,5)   ENCODE lzo
	,"product_key" BIGINT NOT NULL  
	,"channel_key" BIGINT NOT NULL  
	,"inv_location_key" BIGINT NOT NULL  
	,"itm_rtl_price_lc" NUMERIC(20,5)   ENCODE lzo
	,"inv_recn_rpt_dt_key" BIGINT NOT NULL  
	,"e1_to_geo_var_id_dt_key" BIGINT   ENCODE lzo
	,"itm_rtl_price_usd" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_usd" NUMERIC(20,5)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,PRIMARY KEY (product_key, channel_key, inv_location_key, inv_recn_rpt_dt_key)
)
DISTSTYLE EVEN
SORTKEY (
	"inv_recn_rpt_dt_key"
	, "product_key"
	, "channel_key"
	, "inv_location_key"
	)
;
--DROP TABLE "edh"."inv_recn_jdee1_to_strlg_aggr";
CREATE TABLE IF NOT EXISTS "edh"."inv_recn_jdee1_to_strlg_aggr"
(
	"jdee1_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"strlg_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_strlg_var_age" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_strlg_var_qty" NUMERIC(20,5)   ENCODE lzo
	,"product_key" BIGINT NOT NULL  
	,"channel_key" BIGINT NOT NULL  
	,"inv_location_key" BIGINT NOT NULL  
	,"inv_recn_rpt_dt_key" BIGINT NOT NULL  
	,"e1_to_strlg_var_id_dt_key" BIGINT   ENCODE lzo
	,"itm_rtl_price_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_rtl_price_usd" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_usd" NUMERIC(20,5)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,PRIMARY KEY (product_key, channel_key, inv_location_key, inv_recn_rpt_dt_key)
)
DISTSTYLE EVEN
SORTKEY (
	"inv_recn_rpt_dt_key"
	, "product_key"
	, "channel_key"
	, "inv_location_key"
	)
;
--DROP TABLE "edh"."inv_recn_jdee1_to_strlg_aggr_store_level";
CREATE TABLE IF NOT EXISTS "edh"."inv_recn_jdee1_to_strlg_aggr_store_level"
(
	"jdee1_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"strlg_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_strlg_var_age" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_strlg_var_qty" NUMERIC(20,5)   ENCODE lzo
	,"product_key" BIGINT NOT NULL  ENCODE delta32k
	,"channel_key" BIGINT NOT NULL  ENCODE bytedict
	,"inv_recn_rpt_dt_key" BIGINT NOT NULL  ENCODE lzo
	,"e1_to_strlg_var_id_dt_key" BIGINT   ENCODE lzo
	,"itm_rtl_price_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_rtl_price_usd" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_usd" NUMERIC(20,5)   ENCODE mostly32
	,"mapping_nm" VARCHAR(100) NOT NULL  ENCODE runlength
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,PRIMARY KEY (inv_recn_rpt_dt_key, product_key, channel_key)
)
DISTSTYLE EVEN
SORTKEY (
	"inv_recn_rpt_dt_key"
	, "product_key"
	, "channel_key"
	)
;
--DROP TABLE "edh"."inv_recn_strlg_to_geo_aggr";
CREATE TABLE IF NOT EXISTS "edh"."inv_recn_strlg_to_geo_aggr"
(
	"jdee1_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"geo_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"strlg_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"strlg_to_geo_var_age" NUMERIC(20,5)   ENCODE lzo
	,"strlg_to_geo_var_qty" NUMERIC(20,5)   ENCODE lzo
	,"product_key" BIGINT NOT NULL  
	,"channel_key" BIGINT NOT NULL  
	,"supply_type" VARCHAR(100) NOT NULL  
	,"itm_rtl_price_lc" NUMERIC(20,5)   ENCODE lzo
	,"inv_recn_rpt_dt_key" BIGINT NOT NULL  
	,"strlg_to_geo_var_id_dt_key" BIGINT   ENCODE lzo
	,"itm_rtl_price_usd" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_usd" NUMERIC(20,5)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,PRIMARY KEY (product_key, channel_key, inv_recn_rpt_dt_key, supply_type)
)
DISTSTYLE EVEN
SORTKEY (
	"inv_recn_rpt_dt_key"
	, "product_key"
	, "channel_key"
	, "supply_type"
	)
;
--DROP TABLE "edh"."korea_trade_users_dim";
CREATE TABLE IF NOT EXISTS "edh"."korea_trade_users_dim"
(
	"kor_trade_user_key" VARCHAR(10) NOT NULL  ENCODE lzo
	,"last_name" VARCHAR(25)   ENCODE lzo
	,"first_name" VARCHAR(25)   ENCODE lzo
	,"last_updated_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,PRIMARY KEY (kor_trade_user_key)
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."lookup_currency_conversion";
CREATE TABLE IF NOT EXISTS "edh"."lookup_currency_conversion"
(
	"currency_id" BIGINT NOT NULL DEFAULT "identity"(394975, 0, '1,1'::text) ENCODE lzo
	,"local_currency_cd" VARCHAR(3) NOT NULL  
	,"invoice_date_key" BIGINT NOT NULL  
	,"invoice_dt" DATE NOT NULL  
	,"local_currency_to_usd_conv_rate" NUMERIC(20,5)   ENCODE lzo
	,"usd_to_local_currency_conv_rate" NUMERIC(20,5)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"local_currency_cd"
	, "invoice_date_key"
	, "invoice_dt"
	)
;
--DROP TABLE "edh"."lookup_cusmergeref";
CREATE TABLE IF NOT EXISTS "edh"."lookup_cusmergeref"
(
	"source_merge_id" BIGINT NOT NULL  
	,"source_system_nm" VARCHAR(50)   
	,"edh_old_customer_key" BIGINT   
	,"edh_new_customer_key" BIGINT   
	,"source_old_customer_id" BIGINT NOT NULL  
	,"source_new_customer_id" BIGINT NOT NULL  
	,"edh_merge_sync_ind" SMALLINT   ENCODE lzo
	,"create_source_id" INTEGER NOT NULL  ENCODE lzo
	,"update_source_id" INTEGER   ENCODE lzo
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE NOT NULL  ENCODE lzo
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE NOT NULL  ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (source_merge_id)
)
DISTSTYLE KEY
DISTKEY ("source_old_customer_id")
INTERLEAVED SORTKEY (
	"source_old_customer_id"
	, "source_new_customer_id"
	, "edh_old_customer_key"
	, "edh_new_customer_key"
	, "source_merge_id"
	, "source_system_nm"
	)
;
--DROP TABLE "edh"."lookup_delivery_control";
CREATE TABLE IF NOT EXISTS "edh"."lookup_delivery_control"
(
	"delivery_key" BIGINT NOT NULL  ENCODE lzo
	,"source_delivery_id" BIGINT NOT NULL  
	,"source_operation_id" BIGINT NOT NULL  ENCODE lzo
	,"delivery_label_txt" VARCHAR(512)   ENCODE zstd
	,"delivery_message_type_cd" INTEGER   ENCODE lzo
	,"delivery_broad_start_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_tracked_from_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_tracked_to_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_inferred_thru_dt" DATE   ENCODE lzo
	,"delivery_tracked_from_date_key" BIGINT   ENCODE lzo
	,"delivery_tracked_to_date_key" BIGINT   ENCODE lzo
	,"delivery_inferred_thru_date_key" BIGINT   ENCODE lzo
	,"delivery_cd" VARCHAR(200)   ENCODE lzo
	,"delivery_country_cd" VARCHAR(400)   ENCODE lzo
	,"delivery_promotion_period_txt" VARCHAR(256)   ENCODE lzo
	,"delivery_creative_format_dscr" VARCHAR(256)   ENCODE zstd
	,"delivery_creative_version_nm" VARCHAR(256)   ENCODE lzo
	,"delivery_iso_2_char_country_cd" VARCHAR(2)   
	,"delivery_local_currency_cd" VARCHAR(3)   
	,"delivery_is_report_ind" SMALLINT   ENCODE lzo
	,"delivery_has_control_ind" SMALLINT   ENCODE lzo
	,"delivery_has_treated_ind" SMALLINT   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"source_delivery_id"
	, "delivery_local_currency_cd"
	, "delivery_iso_2_char_country_cd"
	)
;
--DROP TABLE "edh"."lookup_dwpcust";
CREATE TABLE IF NOT EXISTS "edh"."lookup_dwpcust"
(
	"seq_num" BIGINT NOT NULL  ENCODE delta
	,"customer_key" BIGINT NOT NULL  ENCODE zstd
	,"source_system" VARCHAR(1000)   ENCODE zstd
	,"customer_number" VARCHAR(1000)   ENCODE zstd
	,"crm_id" VARCHAR(1000)   ENCODE zstd
	,"ecm_cust_id" VARCHAR(1000)   ENCODE zstd
	,"old_ecm_cust_id" VARCHAR(1000)   ENCODE zstd
	,"ecm_merger_date" VARCHAR(1000)   ENCODE zstd
	,"crm_customer_key" VARCHAR(1000)   ENCODE zstd
	,"last_update_stamp" VARCHAR(1000)   ENCODE zstd
	,"rcd_actn_ind" VARCHAR(1000)   ENCODE zstd
	,"rcd_change_tm" VARCHAR(1000)   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (customer_key)
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."lookup_dwpcust_dwpsaleh_cross_ref";
CREATE TABLE IF NOT EXISTS "edh"."lookup_dwpcust_dwpsaleh_cross_ref"
(
	"dwpsaleh_sl_unique_key" BIGINT NOT NULL  ENCODE lzo
	,"dwpcust_customer_key" BIGINT   ENCODE lzo
	,"dwpcust_ecm_cust_id" VARCHAR(1000)   ENCODE lzo
	,"dwpcust_old_ecm_cust_id" VARCHAR(1000)   ENCODE lzo
	,"new_customer_key" BIGINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (dwpsaleh_sl_unique_key)
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."lookup_ecpclrk";
CREATE TABLE IF NOT EXISTS "edh"."lookup_ecpclrk"
(
	"employeeno" VARCHAR(50)   ENCODE lzo
	,"clerkid" INTEGER   ENCODE lzo
	,"store_number" INTEGER   ENCODE lzo
	,"last_update" VARCHAR(50)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."lookup_historical_campaign";
CREATE TABLE IF NOT EXISTS "edh"."lookup_historical_campaign"
(
	"delivery_id" BIGINT NOT NULL  
	,"delivery_label_txt" VARCHAR(200)   ENCODE zstd
	,"is_report_ind" BIGINT   ENCODE lzo
	,"year_nbr" BIGINT   ENCODE lzo
	,"month_cd" VARCHAR(3)   ENCODE lzo
	,"day_nbr" BIGINT   ENCODE lzo
	,"country_nm" VARCHAR(20)   ENCODE lzo
	,"delivery_nature_nm" VARCHAR(64)   ENCODE lzo
	,"delivery_cd" VARCHAR(50)   ENCODE lzo
	,"delivery_creative_format_nm" VARCHAR(64)   ENCODE lzo
	,"delivery_promotion_period_nm" VARCHAR(64)   ENCODE lzo
	,"delivery_segment_cd" VARCHAR(50)   ENCODE lzo
	,"creative_version_nm" VARCHAR(64)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
SORTKEY (
	"delivery_id"
	)
;
--DROP TABLE "edh"."lookup_ipaffinity";
CREATE TABLE IF NOT EXISTS "edh"."lookup_ipaffinity"
(
	"ip_affinity_cd" INTEGER NOT NULL  
	,"ip_affinity_dscr" VARCHAR(10)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
SORTKEY (
	"ip_affinity_cd"
	)
;
--DROP TABLE "edh"."lookup_mbsegment";
CREATE TABLE IF NOT EXISTS "edh"."lookup_mbsegment"
(
	"millward_brown_segment_cd" VARCHAR(2) NOT NULL  
	,"millward_brown_segment_nm" VARCHAR(30) NOT NULL  ENCODE lzo
	,"millward_brown_segment_dscr" VARCHAR(256)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("millward_brown_segment_cd")
SORTKEY (
	"millward_brown_segment_cd"
	)
;
--DROP TABLE "edh"."lookup_nmsbroadlogmsg";
CREATE TABLE IF NOT EXISTS "edh"."lookup_nmsbroadlogmsg"
(
	"broad_log_msg_id" BIGINT NOT NULL  
	,"failure_reason_ind" INTEGER NOT NULL  ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"row_type" VARCHAR(1)   ENCODE zstd
	,PRIMARY KEY (broad_log_msg_id)
)
DISTSTYLE KEY
DISTKEY ("broad_log_msg_id")
SORTKEY (
	"broad_log_msg_id"
	)
;
--DROP TABLE "edh"."lookup_recipientemail";
CREATE TABLE IF NOT EXISTS "edh"."lookup_recipientemail"
(
	"recipient_email_id" BIGINT NOT NULL  ENCODE delta
	,"customer_key" BIGINT   
	,"recipient_id" BIGINT   
	,"ecm_customer_id" BIGINT   
	,"email_address_txt" VARCHAR(1600)   
	,"email_domain_nm" VARCHAR(1600)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,PRIMARY KEY (recipient_email_id)
)
DISTSTYLE KEY
DISTKEY ("ecm_customer_id")
SORTKEY (
	"ecm_customer_id"
	, "recipient_id"
	, "customer_key"
	, "email_address_txt"
	, "recipient_email_id"
	)
;
--DROP TABLE "edh"."lookup_trackingurl";
CREATE TABLE IF NOT EXISTS "edh"."lookup_trackingurl"
(
	"tracking_url_id" BIGINT NOT NULL  
	,"type_ind" INTEGER NOT NULL  ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"row_type" VARCHAR(1)   ENCODE zstd
	,PRIMARY KEY (tracking_url_id)
)
DISTSTYLE KEY
DISTKEY ("tracking_url_id")
SORTKEY (
	"tracking_url_id"
	)
;
--DROP TABLE "edh"."market_dim";
CREATE TABLE IF NOT EXISTS "edh"."market_dim"
(
	"market_key" BIGINT NOT NULL DEFAULT "identity"(395020, 0, '1,1'::text) ENCODE lzo
	,"iso_2_char_country_cd" VARCHAR(2)   
	,"iso_3_char_country_cd" VARCHAR(3)   ENCODE lzo
	,"iso_numeric_country_cd" SMALLINT   ENCODE lzo
	,"english_label_txt" VARCHAR(80)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"market_region_nm" VARCHAR(25)   ENCODE lzo
	,"market_display_nm" VARCHAR(25)   
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (market_key)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"market_display_nm"
	, "iso_2_char_country_cd"
	)
;
--DROP TABLE "edh"."millward_brown_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."millward_brown_customer_dim"
(
	"customer_key" BIGINT NOT NULL  ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"primary_segment_cd" VARCHAR(5)   ENCODE zstd
	,"primary_segment_dscr" VARCHAR(50)   ENCODE zstd
	,"secondary_segment_cd" VARCHAR(5)   ENCODE zstd
	,"secondary_segment_dscr" VARCHAR(50)   ENCODE zstd
	,"primary_segment_probability_rt" NUMERIC(10,6)   ENCODE zstd
	,"secondary_segment_probability_rt" NUMERIC(10,6)   ENCODE zstd
	,"rus_flg" VARCHAR(3)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (customer_key)
)
DISTSTYLE KEY
DISTKEY ("customer_key")
SORTKEY (
	"primary_segment_cd"
	)
;
--DROP TABLE "edh"."missing_key_records_geods";
CREATE TABLE IF NOT EXISTS "edh"."missing_key_records_geods"
(
	"dept_num" BIGINT   
	,"class_num" BIGINT   
	,"sku_number" BIGINT   
	,"bu_number" VARCHAR(20)   
	,"company_num" VARCHAR(20)   
	,"invloc_desc" VARCHAR(20)   
	,"invdt_date" NUMERIC(8,0)   
	,"src_sys_nm" VARCHAR(20)   
	,"oh_qty_amt" NUMERIC(20,5)   
	,"channel_key" BIGINT   
	,"product_key" BIGINT   
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."missing_key_records_jdee1";
CREATE TABLE IF NOT EXISTS "edh"."missing_key_records_jdee1"
(
	"dept_num" BIGINT   ENCODE lzo
	,"class_num" BIGINT   ENCODE delta
	,"sku_number" BIGINT   ENCODE delta32k
	,"bu_number" VARCHAR(20)   ENCODE lzo
	,"company_num" VARCHAR(20)   ENCODE lzo
	,"invloc_desc" VARCHAR(20)   ENCODE lzo
	,"invdt_date" NUMERIC(8,0)   ENCODE lzo
	,"src_sys_nm" VARCHAR(20)   ENCODE lzo
	,"oh_qty_amt" NUMERIC(20,5)   ENCODE lzo
	,"sjcsta_lc" NUMERIC(20,5)   ENCODE lzo
	,"sjcsta_us" NUMERIC(20,5)   
	,"sjpric_lc" NUMERIC(20,5)   ENCODE lzo
	,"sjpric_us" NUMERIC(20,5)   
	,"channel_key" BIGINT   
	,"product_key" BIGINT   ENCODE lzo
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."missing_key_records_strlg";
CREATE TABLE IF NOT EXISTS "edh"."missing_key_records_strlg"
(
	"dept_num" BIGINT   
	,"class_num" BIGINT   
	,"sku_number" BIGINT   
	,"bu_number" VARCHAR(20)   
	,"company_num" VARCHAR(20)   
	,"invloc_desc" VARCHAR(20)   
	,"invdt_date" NUMERIC(8,0)   
	,"src_sys_nm" VARCHAR(20)   
	,"oh_qty_amt" NUMERIC(20,5)   
	,"channel_key" BIGINT   
	,"product_key" BIGINT   
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   
	,"supply_type" VARCHAR(100)   
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."missing_revenue_cntr_channel_records";
CREATE TABLE IF NOT EXISTS "edh"."missing_revenue_cntr_channel_records"
(
	"order_company" VARCHAR(50)   
	,"business_unit" VARCHAR(50)   
	,"transaction_type" VARCHAR(50)   
	,"customer_number" VARCHAR(50)   
	,"channel" VARCHAR(50)   
	,"financial_location" VARCHAR(50)   
	,"subchannel" VARCHAR(50)   
	,"floor" VARCHAR(50)   
	,"department" VARCHAR(50)   
	,"japan_revenue_center" VARCHAR(50)   
	,"revenue_center" VARCHAR(200)   ENCODE lzo
	,"src_table_nm" VARCHAR(50)   
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."orders_fact";
CREATE TABLE IF NOT EXISTS "edh"."orders_fact"
(
	"transactional_number" VARCHAR(40) NOT NULL  ENCODE lzo
	,"line_item_number" INTEGER NOT NULL  ENCODE lzo
	,"upd_user_key" VARCHAR(10)   ENCODE lzo
	,"selling_user_key" VARCHAR(10)   ENCODE lzo
	,"product_dim_key" INTEGER   ENCODE lzo
	,"nationality_key" VARCHAR(50)   ENCODE lzo
	,"date_key" BIGINT   ENCODE lzo
	,"gender" VARCHAR(10)   ENCODE lzo
	,"age" INTEGER   ENCODE lzo
	,"birth_date" DATE   ENCODE lzo
	,"transaction_date" VARCHAR(12)   ENCODE lzo
	,"transaction_type" VARCHAR(10)   ENCODE lzo
	,"gift" CHAR(1)   ENCODE lzo
	,"gift_description" VARCHAR(100)   ENCODE lzo
	,"product_class" INTEGER   ENCODE lzo
	,"department" INTEGER   ENCODE lzo
	,"qty" INTEGER   ENCODE lzo
	,"inserted_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_updated_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"transaction_status" VARCHAR(10)   ENCODE lzo
	,"channel_key" INTEGER   ENCODE lzo
	,"bill_number" VARCHAR(30)   ENCODE lzo
	,"guest_shopper" VARCHAR(40)   ENCODE lzo
	,"list_price" NUMERIC(38,2)   ENCODE lzo
	,"unit_price" NUMERIC(38,2)   ENCODE lzo
	,"extended_price" NUMERIC(38,2)   ENCODE lzo
	,PRIMARY KEY (transactional_number, line_item_number)
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."orders_update_date";
CREATE TABLE IF NOT EXISTS "edh"."orders_update_date"
(
	"most_recent_date" TIMESTAMP WITHOUT TIME ZONE   
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."product_dim";
CREATE TABLE IF NOT EXISTS "edh"."product_dim"
(
	"product_key" BIGINT NOT NULL DEFAULT "identity"(395029, 0, '1,1'::text) ENCODE zstd
	,"source_product_key" BIGINT   ENCODE zstd
	,"source_system_nm" VARCHAR(20)   ENCODE zstd
	,"sku_nbr" BIGINT   ENCODE zstd
	,"product_dscr" VARCHAR(35)   ENCODE zstd
	,"department_nbr" BIGINT   ENCODE zstd
	,"department_dscr" VARCHAR(30)   ENCODE bytedict
	,"class_nbr" BIGINT   ENCODE zstd
	,"class_dscr" VARCHAR(30)   ENCODE zstd
	,"style_nbr" BIGINT   ENCODE zstd
	,"style_dscr" VARCHAR(30)   ENCODE zstd
	,"mips_flg" CHAR(1)   ENCODE zstd
	,"product_type" VARCHAR(30)   ENCODE zstd
	,"product_type_group_nm" VARCHAR(30)   ENCODE lzo
	,"product_collection_nm" VARCHAR(30)   ENCODE zstd
	,"financial_product_category_nm" VARCHAR(40)   ENCODE zstd
	,"financial_product_group_nm" VARCHAR(30)   ENCODE zstd
	,"financial_product_family_nm" VARCHAR(30)   ENCODE bytedict
	,"financial_product_sub_family_nm" VARCHAR(30)   ENCODE bytedict
	,"financial_rollup_flg" CHAR(1)   ENCODE zstd
	,"financial_sort_order_nbr" SMALLINT   ENCODE zstd
	,"material_type" VARCHAR(30)   ENCODE zstd
	,"material_type_group_nm" VARCHAR(30)   ENCODE zstd
	,"primary_gem_content_nm" VARCHAR(30)   ENCODE zstd
	,"gem_color_nm" VARCHAR(5)   ENCODE zstd
	,"gem_clarity_nm" VARCHAR(5)   ENCODE zstd
	,"ir_flg" VARCHAR(1)   ENCODE zstd
	,"discontinued_flg" CHAR(1)   ENCODE zstd
	,"pyramid_flg" CHAR(1)   ENCODE zstd
	,"old_department_nbr" BIGINT   ENCODE zstd
	,"old_class_nbr" BIGINT   ENCODE zstd
	,"old_style_nbr" BIGINT   ENCODE zstd
	,"reclass_dt" DATE   ENCODE zstd
	,"jde_item_nbr" BIGINT   ENCODE zstd
	,"color_clarity_cd" VARCHAR(5)   ENCODE bytedict
	,"logility_item_cd" VARCHAR(18)   ENCODE zstd
	,"logility_color_cd" VARCHAR(2)   ENCODE zstd
	,"logility_clarity_cd" VARCHAR(3)   ENCODE zstd
	,"logility_status_cd" VARCHAR(2)   ENCODE zstd
	,"logility_flg" VARCHAR(1)   ENCODE zstd
	,"mfg_style" VARCHAR(12)   ENCODE zstd
	,"mips_size_dscr" VARCHAR(10)   ENCODE zstd
	,"mips_cons_cd" CHAR(1)   ENCODE zstd
	,"warehouse_only_flg" VARCHAR(1)   ENCODE zstd
	,"set_flg" VARCHAR(1)   ENCODE zstd
	,"product_lunch_dt" DATE   ENCODE zstd
	,"country_of_origin_cd" VARCHAR(8)   ENCODE zstd
	,"country_of_origin_nm" VARCHAR(100)   ENCODE zstd
	,"price_point_cd" VARCHAR(10)   ENCODE lzo
	,"price_point_dscr" VARCHAR(25)   ENCODE zstd
	,"abc_cd" VARCHAR(5)   ENCODE zstd
	,"rank_cd" VARCHAR(5)   ENCODE zstd
	,"unit_sales_cd" BIGINT   ENCODE zstd
	,"prime_sku_nbr" BIGINT   ENCODE zstd
	,"designer_cd" VARCHAR(10)   ENCODE zstd
	,"designer_dscr" VARCHAR(25)   ENCODE zstd
	,"source_last_updt_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"merchandise_collection_nm" VARCHAR(25)   ENCODE bytedict
	,"primary_gem_carat_weight" NUMERIC(8,2)   ENCODE zstd
	,"primary_gem_cut_txt" VARCHAR(30)   ENCODE zstd
	,"primary_gem_shape_txt" VARCHAR(30)   ENCODE zstd
	,"motif_dscr" VARCHAR(30)   ENCODE zstd
	,"mips_retail_price_amt" NUMERIC(20,5)   ENCODE zstd
	,"mips_average_cost_amt" NUMERIC(20,5)   ENCODE zstd
	,"mips_consigned_cost_amt" NUMERIC(20,5)   ENCODE zstd
	,"first_receipt_dt" DATE   ENCODE zstd
	,"maps_id" VARCHAR(15)   ENCODE zstd
	,"maps_dscr" VARCHAR(30)   ENCODE zstd
	,"cmrp_color_cd" VARCHAR(2)   ENCODE zstd
	,"cmrp_clarity_cd" VARCHAR(4)   ENCODE bytedict
	,"ring_width_milimeters_nbr" NUMERIC(8,2)   ENCODE zstd
	,"mips_current_cost_amt" NUMERIC(20,5)   ENCODE zstd
	,"primary_gem_group" VARCHAR(30)   ENCODE lzo
	,"seasonal_ind" VARCHAR(1)   ENCODE lzo
	,"epd_product_revised_merchandise_collection_nm" VARCHAR(200)   ENCODE lzo
	,"epd_product_type_tier_2_nm" VARCHAR(200)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (product_key)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"source_product_key"
	, "product_key"
	, "financial_product_family_nm"
	, "department_nbr"
	, "merchandise_collection_nm"
	, "logility_status_cd"
	, "ir_flg"
	, "maps_id"
	)
;
--DROP TABLE "edh"."sales_history_fact";
CREATE TABLE IF NOT EXISTS "edh"."sales_history_fact"
(
	"sales_history_key" BIGINT NOT NULL DEFAULT "identity"(395034, 0, '1,1'::text) ENCODE zstd
	,"source_sales_history_key" BIGINT NOT NULL  ENCODE zstd
	,"clerk_group_key" BIGINT   ENCODE zstd
	,"gl_date_key" BIGINT   ENCODE zstd
	,"invoice_date_key" BIGINT   ENCODE zstd
	,"order_date_key" BIGINT   ENCODE zstd
	,"customer_key" BIGINT   
	,"product_key" BIGINT   ENCODE zstd
	,"channel_key" BIGINT   ENCODE zstd
	,"time_key" BIGINT   ENCODE zstd
	,"tourism_key" BIGINT   ENCODE zstd
	,"transaction_key" BIGINT   ENCODE zstd
	,"number_of_units_qty" BIGINT   ENCODE zstd
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"extended_cost_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"unit_price_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"unit_cost_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"tax_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"discount_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"discount_percent_rt" NUMERIC(10,6)   ENCODE zstd
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"extended_cost_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"unit_price_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"unit_cost_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"tax_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"discount_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"extended_unit_price_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"extended_unit_price_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"store_nbr" BIGINT   ENCODE zstd
	,"channel_cd" VARCHAR(2)   ENCODE zstd
	,"invoice_nbr" VARCHAR(15)   ENCODE zstd
	,"line_nbr" BIGINT   ENCODE zstd
	,"recipient_cd" VARCHAR(20)   ENCODE zstd
	,"department_nbr" BIGINT   ENCODE zstd
	,"class_nbr" BIGINT   ENCODE zstd
	,"date_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"commisionable_sale_ind" SMALLINT   ENCODE lzo
	,"zero_transaction_ind" SMALLINT   ENCODE zstd
	,"gift_item_cd" CHAR(1)   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (sales_history_key)
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "transaction_key"
	, "product_key"
	, "extended_unit_price_usd_amt"
	, "gl_date_key"
	, "invoice_nbr"
	, "zero_transaction_ind"
	, "date_tmstmp"
	)
;
--DROP TABLE "edh"."source_system_dim";
CREATE TABLE IF NOT EXISTS "edh"."source_system_dim"
(
	"source_system_key" BIGINT NOT NULL DEFAULT "identity"(395039, 0, '1,1'::text) ENCODE lzo
	,"source_system_id" BIGINT   
	,"source_system_short_dscr" VARCHAR(100)   ENCODE lzo
	,"source_system_long_dscr" VARCHAR(200)   ENCODE lzo
	,"source_system_country_display_nm" VARCHAR(100)   ENCODE lzo
	,"source_system_country_iso_cd" VARCHAR(2)   
	,"source_system_country_iso_nm" VARCHAR(100)   ENCODE lzo
	,"source_created_timestamp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_updated_timestamp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (source_system_key)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"source_system_id"
	, "source_system_country_iso_cd"
	)
;
--DROP TABLE "edh"."sterling_relevant_dates";
CREATE TABLE IF NOT EXISTS "edh"."sterling_relevant_dates"
(
	"inv_balance_dt_key" BIGINT   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_address_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_address_fact"
(
	"source_system_nm" VARCHAR(30)   ENCODE zstd
	,"source_address_id" BIGINT   ENCODE zstd
	,"country_id" BIGINT   ENCODE zstd
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"country_iso_2_char_cd" VARCHAR(2)   ENCODE zstd
	,"country_display_nm" VARCHAR(100)   ENCODE zstd
	,"company_nm" VARCHAR(400)   ENCODE zstd
	,"shipping_instructions_txt" VARCHAR(800)   ENCODE zstd
	,"building_name" VARCHAR(400)   ENCODE zstd
	,"building_1_name" VARCHAR(400)   ENCODE zstd
	,"address_line_1_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_2_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_3_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_4_txt" VARCHAR(400)   ENCODE zstd
	,"city_nm" VARCHAR(280)   ENCODE zstd
	,"city_2_nm" VARCHAR(280)   ENCODE zstd
	,"city_3_nm" VARCHAR(280)   ENCODE lzo
	,"city_4_nm" VARCHAR(280)   ENCODE lzo
	,"alternate_city_nm" VARCHAR(280)   ENCODE zstd
	,"region_nm" VARCHAR(400)   ENCODE zstd
	,"region_2_nm" VARCHAR(400)   ENCODE zstd
	,"postal_cd" VARCHAR(80)   ENCODE zstd
	,"postal_1_cd" VARCHAR(80)   ENCODE zstd
	,"postal_2_cd" VARCHAR(80)   ENCODE zstd
	,"county_nm" VARCHAR(400)   ENCODE zstd
	,"domestic_flg" SMALLINT   ENCODE zstd
	,"active_ind" SMALLINT   ENCODE zstd
	,"active_indicator_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"active_indicator_update_user" VARCHAR(80)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"district_cd" VARCHAR(160)   ENCODE lzo
	,"review_id" VARCHAR(50)   ENCODE lzo
	,"validated_flg" SMALLINT   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_auth_employee";
CREATE TABLE IF NOT EXISTS "edh"."stg_auth_employee"
(
	"applicationid" VARCHAR(100)   ENCODE lzo
	,"clerkid" BIGINT   ENCODE lzo
	,"datecreated" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"datelastmodified" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"employeeno" VARCHAR(11)   ENCODE lzo
	,"isactive" INTEGER   ENCODE lzo
	,"isdefault" INTEGER   ENCODE lzo
	,"region" VARCHAR(25)   ENCODE lzo
	,"storeno" VARCHAR(15)   ENCODE lzo
	,"userid" VARCHAR(100)   ENCODE lzo
	,"rcd_actn_ind" CHAR(1)   ENCODE lzo
	,"rcd_change_tm" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_channel_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_channel_dim"
(
	"source_channel_key" BIGINT   ENCODE lzo
	,"revenue_center_nm" VARCHAR(40)   ENCODE lzo
	,"business_group_nm" VARCHAR(25)   ENCODE lzo
	,"domestic_international_type" VARCHAR(25)   ENCODE lzo
	,"sales_division_nm" VARCHAR(25)   ENCODE lzo
	,"channel_nm" VARCHAR(25)   ENCODE lzo
	,"sub_channel_nm" VARCHAR(25)   ENCODE lzo
	,"company_nbr" VARCHAR(5)   ENCODE lzo
	,"company_nm" VARCHAR(40)   ENCODE lzo
	,"currency_cd" VARCHAR(3)   ENCODE lzo
	,"currency_symbol_txt" VARCHAR(10)   ENCODE lzo
	,"part_of_the_world_nm" VARCHAR(25)   ENCODE lzo
	,"sub_part_of_the_world_nm" VARCHAR(25)   ENCODE lzo
	,"display_country_nm" VARCHAR(100)   ENCODE lzo
	,"iso_country_cd" VARCHAR(2)   ENCODE lzo
	,"iso_country_nm" VARCHAR(100)   ENCODE lzo
	,"region_nm" VARCHAR(25)   ENCODE lzo
	,"territory_nm" VARCHAR(25)   ENCODE lzo
	,"location_nm" VARCHAR(40)   ENCODE lzo
	,"trade_account_nbr" VARCHAR(25)   ENCODE lzo
	,"dgp_receiving_company_nbr" VARCHAR(25)   ENCODE lzo
	,"retail_chain_nm" VARCHAR(25)   ENCODE lzo
	,"revenue_center_type" VARCHAR(40)   ENCODE lzo
	,"chain_txt" VARCHAR(25)   ENCODE lzo
	,"new_comparable_type" VARCHAR(15)   ENCODE lzo
	,"store_open_dt" DATE   ENCODE lzo
	,"store_close_dt" DATE   ENCODE lzo
	,"comparable_dt" DATE   ENCODE lzo
	,"mips_store_nbr" BIGINT   ENCODE lzo
	,"mips_store_nm" VARCHAR(40)   ENCODE lzo
	,"closed_days_group_cd" VARCHAR(10)   ENCODE lzo
	,"logility_store_nbr" BIGINT   ENCODE lzo
	,"logility_region_cd" VARCHAR(5)   ENCODE lzo
	,"logility_channel_nbr" BIGINT   ENCODE lzo
	,"region_sort_nbr" INTEGER   ENCODE lzo
	,"part_of_the_world_sort_nbr" INTEGER   ENCODE lzo
	,"group_channel_sub_channel_sort_nbr" INTEGER   ENCODE lzo
	,"business_type_sort_nbr" INTEGER   ENCODE lzo
	,"business_type" VARCHAR(25)   ENCODE lzo
	,"unified_channel_nm" VARCHAR(25)   ENCODE lzo
	,"unified_sub_channel_nm" VARCHAR(25)   ENCODE lzo
	,"plan_open_dt" DATE   ENCODE lzo
	,"store_size_txt" VARCHAR(25)   ENCODE lzo
	,"store_city_nm" VARCHAR(25)   ENCODE lzo
	,"store_state_province_cd" VARCHAR(2)   ENCODE lzo
	,"segment_summary_nm" VARCHAR(25)   ENCODE lzo
	,"segment_nm" VARCHAR(25)   ENCODE lzo
	,"sub_segment_nm" VARCHAR(25)   ENCODE lzo
	,"segment_sort_order_nbr" INTEGER   ENCODE lzo
	,"territory_sort_order_nbr" INTEGER   ENCODE lzo
	,"merch_store_size_txt" VARCHAR(25)   ENCODE lzo
	,"store_alpha_cd" VARCHAR(2)   ENCODE lzo
	,"price_market_nm" VARCHAR(25)   ENCODE lzo
	,"global_region_summary_nm" VARCHAR(25)   ENCODE lzo
	,"public_global_region_nm" VARCHAR(25)   ENCODE lzo
	,"global_region_nm" VARCHAR(25)   ENCODE lzo
	,"global_sub_region_nm" VARCHAR(25)   ENCODE lzo
	,"global_region_sort_nbr" INTEGER   ENCODE lzo
	,"merch_region_nm" VARCHAR(25)   ENCODE lzo
	,"merch_market_nm" VARCHAR(25)   ENCODE lzo
	,"store_longitude_nbr" VARCHAR(30)   ENCODE lzo
	,"store_latitude_nbr" VARCHAR(30)   ENCODE lzo
	,"store_postal_cd" VARCHAR(25)   ENCODE lzo
	,"include_in_sales_flg" VARCHAR(1)   ENCODE lzo
	,"include_in_inventory_flg" VARCHAR(1)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_clerk_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_clerk_dim"
(
	"source_clerk_key" BIGINT   ENCODE delta32k
	,"clerk_id" BIGINT   ENCODE zstd
	,"active_record_ind" VARCHAR(1)   ENCODE zstd
	,"clerk_first_nm" VARCHAR(50)   ENCODE zstd
	,"clerk_last_nm" VARCHAR(50)   ENCODE zstd
	,"clerk_class_txt" VARCHAR(10)   ENCODE zstd
	,"employee_nbr" VARCHAR(11)   ENCODE zstd
	,"company_nbr" VARCHAR(5)   ENCODE zstd
	,"channel_type" VARCHAR(9)   ENCODE zstd
	,"floor_txt" VARCHAR(10)   ENCODE lzo
	,"job_cd" VARCHAR(6)   ENCODE zstd
	,"commisionable_ind" VARCHAR(1)   ENCODE lzo
	,"clerk_status_txt" VARCHAR(8)   ENCODE zstd
	,"status_dt" DATE   ENCODE lzo
	,"store_nbr" INTEGER   ENCODE lzo
	,"iso_country_cd" VARCHAR(2)   ENCODE zstd
	,"iso_country_nm" VARCHAR(100)   ENCODE zstd
	,"country_display_nm" VARCHAR(100)   ENCODE zstd
	,"location_nm" VARCHAR(40)   ENCODE zstd
	,"region_nm" VARCHAR(25)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_clerk_group_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_clerk_group_dim"
(
	"source_clerk_group_key" BIGINT   ENCODE zstd
	,"clerk_key" BIGINT   ENCODE zstd
	,"clerks_in_group_qty" SMALLINT   ENCODE zstd
	,"clerk_sequence_nbr" SMALLINT   ENCODE zstd
	,"weighting_factor_rt" NUMERIC(3,1)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_clienteling_action_opportunity_attr_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_clienteling_action_opportunity_attr_dim"
(
	"action_item_type_cd" BIGINT   ENCODE lzo
	,"action_item_type_dscr" VARCHAR(100)   ENCODE lzo
	,"action_priority_type_cd" BIGINT   ENCODE lzo
	,"action_priority_type_dscr" VARCHAR(100)   ENCODE lzo
	,"outreach_action_reason_type_cd" BIGINT   ENCODE lzo
	,"outreach_action_reason_type_dscr" VARCHAR(100)   ENCODE lzo
	,"outreach_action_method_type_cd" BIGINT   ENCODE lzo
	,"outreach_action_method_type_dscr" VARCHAR(100)   ENCODE lzo
	,"action_initiative_type_cd" BIGINT   ENCODE lzo
	,"action_initiative_type_dscr" VARCHAR(100)   ENCODE lzo
	,"action_status_type_cd" BIGINT   ENCODE lzo
	,"action_status_type_dscr" VARCHAR(100)   ENCODE lzo
	,"action_gift_type_cd" BIGINT   ENCODE lzo
	,"action_gift_type_dscr" VARCHAR(100)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."stg_clienteling_action_opportunity_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_clienteling_action_opportunity_fact"
(
	"source_action_opportunity_key" BIGINT NOT NULL  ENCODE lzo
	,"clienteling_act_opp_attribute_key" BIGINT   ENCODE lzo
	,"creator_clerk_key" BIGINT   ENCODE lzo
	,"assigned_to_clerk_key" BIGINT   ENCODE lzo
	,"assigned_clerk_key" BIGINT   ENCODE lzo
	,"associated_channel_key" BIGINT   ENCODE lzo
	,"customer_key" BIGINT   ENCODE lzo
	,"gift_product_sku" VARCHAR(20)   ENCODE lzo
	,"gift_country_id" BIGINT   ENCODE lzo
	,"gift_retail_value_local_currency_amount" NUMERIC(38,5)   ENCODE lzo
	,"gift_description" VARCHAR(1000)   ENCODE lzo
	,"source_country_id" BIGINT   ENCODE lzo
	,"created_date_key" BIGINT   ENCODE lzo
	,"due_date_key" BIGINT   ENCODE lzo
	,"completed_date_key" BIGINT   ENCODE lzo
	,"modified_date_key" BIGINT   ENCODE lzo
	,"consultation_date_key" BIGINT   ENCODE lzo
	,"associated_store_nbr" BIGINT   ENCODE lzo
	,"created_by_id" VARCHAR(20)   ENCODE lzo
	,"modified_by_id" VARCHAR(20)   ENCODE lzo
	,"reviewed_by_id" VARCHAR(20)   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"load_script_nm" VARCHAR(300)   ENCODE lzo
	,"stg_mapping_nm" VARCHAR(100)   ENCODE lzo
	,"stg_workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."stg_clienteling_emp_task_attr_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_clienteling_emp_task_attr_dim"
(
	"task_type_cd" BIGINT   ENCODE lzo
	,"task_type_dscr" VARCHAR(100)   ENCODE lzo
	,"task_outcome_cd" BIGINT   ENCODE lzo
	,"task_outcome_dscr" VARCHAR(100)   ENCODE lzo
	,"customer_contact_reason_cd" BIGINT   ENCODE lzo
	,"customer_contact_reason_dscr" VARCHAR(160)   ENCODE lzo
	,"task_initiative_cd" BIGINT   ENCODE lzo
	,"task_initiative_dscr" VARCHAR(100)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."stg_clienteling_employee_task_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_clienteling_employee_task_fact"
(
	"source_cl_employee_task_key" BIGINT NOT NULL  ENCODE lzo
	,"customer_key" BIGINT   ENCODE lzo
	,"assigned_to_clerk_key" BIGINT   ENCODE lzo
	,"receiver_creator_clerk_key" BIGINT   ENCODE lzo
	,"created_date_key" BIGINT   ENCODE lzo
	,"due_date_key" BIGINT   ENCODE lzo
	,"completed_date_key" BIGINT   ENCODE lzo
	,"reminder_date_key" BIGINT   ENCODE lzo
	,"clienteling_emp_task_attr_key" BIGINT   ENCODE lzo
	,"cust_email_contact_task_key" BIGINT   ENCODE lzo
	,"channel_key" BIGINT   ENCODE lzo
	,"source_country_id" BIGINT   ENCODE lzo
	,"is_complete_flag" INTEGER   ENCODE lzo
	,"task_title_txt" VARCHAR(1000)   ENCODE lzo
	,"task_description_txt" VARCHAR(1000)   ENCODE lzo
	,"store_nbr" BIGINT   ENCODE lzo
	,"priority_nbr" INTEGER   ENCODE lzo
	,"reminder_duration_nbr" INTEGER   ENCODE lzo
	,"created_by_nm" VARCHAR(20)   ENCODE lzo
	,"modified_by_nm" VARCHAR(20)   ENCODE lzo
	,"reviewed_by_nm" VARCHAR(20)   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"load_script_nm" VARCHAR(300)   ENCODE lzo
	,"stg_mapping_nm" VARCHAR(255)   ENCODE lzo
	,"stg_workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,"comment_txt" VARCHAR(4000)   ENCODE lzo
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."stg_country_master";
CREATE TABLE IF NOT EXISTS "edh"."stg_country_master"
(
	"country_id" BIGINT   ENCODE lzo
	,"country_iso_2_char_cd" VARCHAR(2)   ENCODE lzo
	,"country_iso_3_char_cd" VARCHAR(3)   ENCODE lzo
	,"country_iso_numeric_cd" VARCHAR(3)   ENCODE lzo
	,"country_iso_nm" VARCHAR(100)   ENCODE lzo
	,"country_display_nm" VARCHAR(100)   ENCODE lzo
	,"country_fips104_cd" VARCHAR(50)   ENCODE lzo
	,"country_currency_cd" VARCHAR(3)   ENCODE lzo
	,"country_dial_cd" VARCHAR(25)   ENCODE lzo
	,"nationality_singular_nm" VARCHAR(100)   ENCODE lzo
	,"nationality_plural_nm" VARCHAR(100)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_currency_master";
CREATE TABLE IF NOT EXISTS "edh"."stg_currency_master"
(
	"currency_cd" VARCHAR(3)   ENCODE lzo
	,"currency_numeric_cd" SMALLINT   ENCODE lzo
	,"currency_nm" VARCHAR(100)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_customer_address_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_customer_address_fact"
(
	"customer_key" BIGINT   ENCODE lzo
	,"create_source_system_key" BIGINT   ENCODE lzo
	,"update_source_system_key" BIGINT   ENCODE lzo
	,"address_id" BIGINT   ENCODE lzo
	,"customer_address_id" BIGINT   ENCODE lzo
	,"address_type_id" BIGINT   ENCODE lzo
	,"address_type_dscr" VARCHAR(100)   ENCODE lzo
	,"fraud_type_id" BIGINT   ENCODE lzo
	,"fraud_type_dscr" VARCHAR(50)   ENCODE lzo
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"primary_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE runlength
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_customer_bio_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_customer_bio_fact"
(
	"customer_key" BIGINT   ENCODE zstd
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"bio_category_selection_id" BIGINT   ENCODE zstd
	,"bio_category_hierarchy_id" BIGINT   ENCODE zstd
	,"bio_category_parent_type_nm" VARCHAR(160)   ENCODE zstd
	,"bio_category_child_type_nm" VARCHAR(160)   ENCODE zstd
	,"notes_txt" VARCHAR(16000)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_customer_comment_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_customer_comment_fact"
(
	"customer_key" BIGINT   ENCODE zstd
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"comment_id" BIGINT   ENCODE zstd
	,"comment_type_id" BIGINT   ENCODE zstd
	,"comment_type_dscr" VARCHAR(50)   ENCODE zstd
	,"comment_txt" VARCHAR(16000)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_customer_dim"
(
	"create_source_system_key" BIGINT   ENCODE lzo
	,"update_source_system_key" BIGINT   ENCODE lzo
	,"original_system_nm" VARCHAR(30)   ENCODE lzo
	,"source_customer_key" BIGINT   ENCODE lzo
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"crm_system_id" BIGINT   ENCODE zstd
	,"customer_nbr" BIGINT   ENCODE zstd
	,"source_system_nm" VARCHAR(20)   ENCODE lzo
	,"source_created_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_last_updt_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"client_type_id" SMALLINT   ENCODE lzo
	,"client_type_dscr" VARCHAR(100)   ENCODE lzo
	,"assigned_employee_cd" VARCHAR(11)   ENCODE lzo
	,"customer_title_txt" VARCHAR(400)   ENCODE lzo
	,"customer_salutation_nm" VARCHAR(400)   ENCODE lzo
	,"customer_first_nm" VARCHAR(200)   ENCODE lzo
	,"customer_middle_nm" VARCHAR(200)   ENCODE lzo
	,"customer_last_nm" VARCHAR(400)   ENCODE lzo
	,"customer_suffix_txt" VARCHAR(320)   ENCODE lzo
	,"customer_full_nm" VARCHAR(400)   ENCODE lzo
	,"customer_post_nm" VARCHAR(400)   ENCODE lzo
	,"employee_ind" SMALLINT   ENCODE lzo
	,"employee_nbr" VARCHAR(11)   ENCODE lzo
	,"gender_nm" VARCHAR(20)   ENCODE lzo
	,"birth_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"customer_marital_status_cd" VARCHAR(1)   ENCODE lzo
	,"customer_marital_status_dscr" VARCHAR(100)   ENCODE lzo
	,"customer_nationality" VARCHAR(50)   ENCODE lzo
	,"first_purchase_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"last_purchased_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"spend_36_months_amt" NUMERIC(20,5)   ENCODE lzo
	,"spend_lifetime_amt" NUMERIC(20,5)   ENCODE lzo
	,"tr_cd" VARCHAR(4)   ENCODE lzo
	,"tr_dscr" VARCHAR(25)   ENCODE lzo
	,"ecm_active_ind" SMALLINT   ENCODE lzo
	,"cic_flg" CHAR(1)   ENCODE lzo
	,"cic_updt_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"allow_mail_ind" CHAR(1)   ENCODE lzo
	,"allow_email_ind" CHAR(1)   ENCODE lzo
	,"allow_phone_ind" CHAR(1)   ENCODE lzo
	,"allow_txt_ind" CHAR(1)   ENCODE lzo
	,"address_ind" SMALLINT   ENCODE lzo
	,"email_ind" SMALLINT   ENCODE lzo
	,"phone_ind" VARCHAR(25)   ENCODE lzo
	,"household_id" INTEGER   ENCODE lzo
	,"household_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"household_salutation_txt" VARCHAR(800)   ENCODE lzo
	,"household_relationship_type" VARCHAR(25)   ENCODE lzo
	,"household_relationship_driver_ind" VARCHAR(25)   ENCODE lzo
	,"address_line_1_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_2_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_3_txt" VARCHAR(400)   ENCODE zstd
	,"address_line_4_txt" VARCHAR(400)   ENCODE lzo
	,"building_nm" VARCHAR(400)   ENCODE zstd
	,"building_2_nm" VARCHAR(400)   ENCODE zstd
	,"city_nm" VARCHAR(280)   ENCODE zstd
	,"city_2_nm" VARCHAR(280)   ENCODE zstd
	,"city_3_nm" VARCHAR(280)   ENCODE zstd
	,"city_4_nm" VARCHAR(280)   ENCODE lzo
	,"province_nm" VARCHAR(400)   ENCODE lzo
	,"state_nm" VARCHAR(400)   ENCODE zstd
	,"district_cd" VARCHAR(160)   ENCODE zstd
	,"display_country_nm" VARCHAR(100)   ENCODE zstd
	,"country_iso_2_cd" VARCHAR(2)   ENCODE zstd
	,"country_iso_nm" VARCHAR(100)   ENCODE zstd
	,"postal_cd" VARCHAR(80)   ENCODE zstd
	,"postal_1_cd" VARCHAR(80)   ENCODE zstd
	,"postal_2_cd" VARCHAR(80)   ENCODE zstd
	,"address_validation_ind" CHAR(1)   ENCODE zstd
	,"customer_email_txt" VARCHAR(800)   ENCODE lzo
	,"phone_nbr" VARCHAR(30)   ENCODE lzo
	,"phone_country_dial_nbr" VARCHAR(25)   ENCODE lzo
	,"phone_country_display_nm" VARCHAR(100)   ENCODE lzo
	,"phone_country_iso_nm" VARCHAR(100)   ENCODE lzo
	,"phone_country_iso_cd" VARCHAR(2)   ENCODE lzo
	,"sms_phone_nbr" VARCHAR(30)   ENCODE lzo
	,"sms_country_dial_nbr" VARCHAR(20)   ENCODE lzo
	,"sms_country_display_nm" VARCHAR(100)   ENCODE lzo
	,"sms_country_iso_nm" VARCHAR(100)   ENCODE lzo
	,"sms_country_iso_cd" VARCHAR(2)   ENCODE lzo
	,"ecm_originated_country_nm" VARCHAR(100)   ENCODE lzo
	,"ecm_originated_country_cd" VARCHAR(2)   ENCODE lzo
	,"jde_customer_cd" VARCHAR(25)   ENCODE lzo
	,"account_source_nm" VARCHAR(25)   ENCODE lzo
	,"marketing_cd" VARCHAR(4)   ENCODE lzo
	,"marketing_dscr" VARCHAR(25)   ENCODE lzo
	,"month_opened_nbr" SMALLINT   ENCODE lzo
	,"year_opened_nbr" SMALLINT   ENCODE lzo
	,"payment_option_nm" VARCHAR(15)   ENCODE lzo
	,"search_type" VARCHAR(3)   ENCODE lzo
	,"current_se_cd" SMALLINT   ENCODE lzo
	,"source_recipient_id" BIGINT   ENCODE lzo
	,"recipient_black_list_email_sent_to_ecm_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_black_list_email_sent_to_ecm_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_email_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_fax_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_mobile_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_phone_ind" SMALLINT   ENCODE lzo
	,"recipient_black_list_post_mail_ind" SMALLINT   ENCODE lzo
	,"recipient_computed_gender_code" SMALLINT   ENCODE lzo
	,"recipient_computed_gender_dscr" VARCHAR(20)   ENCODE lzo
	,"recipient_ecard_opted_ind" SMALLINT   ENCODE lzo
	,"recipient_mbs_acclaim_customer_id" BIGINT   ENCODE lzo
	,"recipient_mbs_pc7_b2b_customer_id" BIGINT   ENCODE lzo
	,"recipient_mbs_pc7_b2c_customer_id" BIGINT   ENCODE lzo
	,"recipient_black_list_postal_mail_reason_cd" VARCHAR(25)   ENCODE lzo
	,"recipient_external_src_cd" VARCHAR(10)   ENCODE lzo
	,"recipient_external_src_dscr" VARCHAR(25)   ENCODE lzo
	,"recipient_src_file_nm" VARCHAR(1020)   ENCODE lzo
	,"recipient_outreach_country_numeric_cd" SMALLINT   ENCODE lzo
	,"recipient_outreach_country_dscr" VARCHAR(100)   ENCODE lzo
	,"recipient_black_list_email_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_black_list_postal_mail_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_external_src_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_external_src_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_last_click_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_last_opened_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_japan_opt_in_cd" SMALLINT   ENCODE lzo
	,"recipient_japan_opt_in_dscr" VARCHAR(25)   ENCODE lzo
	,"outreach_flg" SMALLINT   ENCODE lzo
	,"outreach_dscr" VARCHAR(50)   ENCODE lzo
	,"recipient_external_src_database_nm" VARCHAR(255)   ENCODE lzo
	,"recipient_external_src_database_dscr" VARCHAR(255)   ENCODE lzo
	,"client_level_type_id" SMALLINT   ENCODE lzo
	,"client_level_type_dscr" VARCHAR(50)   ENCODE lzo
	,"country_language_id" SMALLINT   ENCODE lzo
	,"country_language_dscr" VARCHAR(100)   ENCODE lzo
	,"recipient_contact_preference_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"recipient_contact_preference_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,"data_permission_flag" CHAR(1) ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_customer_email_contact_task_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_customer_email_contact_task_dim"
(
	"source_task_key" BIGINT   ENCODE lzo
	,"contact_greeting_type_cd" BIGINT   ENCODE lzo
	,"contact_greeting_type_dscr" VARCHAR(100)   ENCODE lzo
	,"country_language_cd" BIGINT   ENCODE lzo
	,"country_language_dscr" VARCHAR(100)   ENCODE lzo
	,"contact_closing_type_cd" BIGINT   ENCODE lzo
	,"contact_closing_type_dscr" VARCHAR(200)   ENCODE lzo
	,"email_template_nm" VARCHAR(100)   ENCODE lzo
	,"recipient_email_address_txt" VARCHAR(100)   ENCODE lzo
	,"email_subject_txt" VARCHAR(500)   ENCODE lzo
	,"sent_bcc_ind" INTEGER   ENCODE lzo
	,"bcc_email_addresses_txt" VARCHAR(500)   ENCODE lzo
	,"recipient_salutation_txt" VARCHAR(100)   ENCODE lzo
	,"recipient_first_nm" VARCHAR(100)   ENCODE lzo
	,"recipient_last_nm" VARCHAR(100)   ENCODE lzo
	,"email_message_txt" VARCHAR(8000)   ENCODE lzo
	,"employee_nm" VARCHAR(85)   ENCODE lzo
	,"employee_job_title_nm" VARCHAR(100)   ENCODE lzo
	,"employee_email_address_txt" VARCHAR(100)   ENCODE lzo
	,"employee_phone_txt" VARCHAR(30)   ENCODE lzo
	,"contact_task_status_type_cd" BIGINT   ENCODE lzo
	,"contact_task_status_type_dscr" VARCHAR(100)   ENCODE lzo
	,"external_request_id" BIGINT   ENCODE lzo
	,"create_source_id" INTEGER   ENCODE lzo
	,"status_details_txt" VARCHAR(4000)   ENCODE lzo
	,"date_created_tmstmp" VARCHAR(100)   ENCODE lzo
	,"date_last_modified_tmstmp" VARCHAR(100)   ENCODE lzo
	,"ecard_batch_nbr" INTEGER   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."stg_customer_email_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_customer_email_dim"
(
	"customer_email_key" BIGINT   ENCODE zstd
	,"customer_key" BIGINT   ENCODE zstd
	,"create_src_system_key" BIGINT   ENCODE lzo
	,"update_src_system_key" BIGINT   ENCODE lzo
	,"adobe_campaign_email_id" BIGINT   ENCODE lzo
	,"ecm_email_id" BIGINT   ENCODE zstd
	,"edw_email_id" BIGINT   ENCODE lzo
	,"email_source_nm" VARCHAR(3)   ENCODE zstd
	,"black_list_ecard_ind" SMALLINT   ENCODE lzo
	,"black_list_email_ind" SMALLINT   ENCODE lzo
	,"src_delete_ind" SMALLINT   ENCODE lzo
	,"primary_ind" SMALLINT   ENCODE zstd
	,"active_ind" SMALLINT   ENCODE zstd
	,"personalize_ind" SMALLINT   ENCODE lzo
	,"email_address_txt" VARCHAR(800)   ENCODE zstd
	,"external_src_database_nm" VARCHAR(1020)   ENCODE lzo
	,"black_list_ecard_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"black_list_email_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"src_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"src_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"opt_out_change_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"email_format_cd" BIGINT   ENCODE lzo
	,"email_format_dscr" VARCHAR(50)   ENCODE lzo
	,"email_type_cd" SMALLINT   ENCODE zstd
	,"email_type_dscr" VARCHAR(100)   ENCODE zstd
	,"active_ind_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"active_ind_create_user_nm" VARCHAR(20)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expire_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_customer_level_history_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_customer_level_history_fact"
(
	"customer_key" BIGINT   ENCODE zstd
	,"client_level_id" VARCHAR(4)   ENCODE zstd
	,"client_level_dscr" VARCHAR(50)   ENCODE zstd
	,"source_system_nm" VARCHAR(20)   ENCODE zstd
	,"from_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"to_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_current_ind" CHAR(1)   ENCODE zstd
	,"tr_process_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmst" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_customer_name_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_customer_name_fact"
(
	"customer_key" BIGINT   ENCODE zstd
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"name_id" BIGINT   ENCODE zstd
	,"customer_title_txt" VARCHAR(400)   ENCODE zstd
	,"customer_first_nm" VARCHAR(200)   ENCODE zstd
	,"customer_last_nm" VARCHAR(400)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_customer_phone_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_customer_phone_fact"
(
	"customer_key" BIGINT   ENCODE zstd
	,"create_source_system_key" BIGINT   ENCODE lzo
	,"update_source_system_key" BIGINT   ENCODE lzo
	,"customer_phone_id" BIGINT   ENCODE zstd
	,"phone_type_id" BIGINT   ENCODE zstd
	,"phone_type_dscr" VARCHAR(100)   ENCODE zstd
	,"fraud_type_id" BIGINT   ENCODE zstd
	,"fraud_type_dscr" VARCHAR(100)   ENCODE zstd
	,"phone_nbr" VARCHAR(30)   ENCODE zstd
	,"phone_extension_nbr" VARCHAR(10)   ENCODE zstd
	,"call_priority_nbr" INTEGER   ENCODE zstd
	,"phone_country_iso_cd" VARCHAR(2)   ENCODE zstd
	,"phone_country_iso_nm" VARCHAR(100)   ENCODE zstd
	,"phone_country_display_nm" VARCHAR(100)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"active_ind" SMALLINT   ENCODE zstd
	,"active_indicator_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"active_indicator_update_user_nm" VARCHAR(50)   ENCODE zstd
	,"primary_ind" SMALLINT   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_customer_preferred_interest_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_customer_preferred_interest_fact"
(
	"customer_key" BIGINT   ENCODE zstd
	,"create_source_system_key" BIGINT   ENCODE zstd
	,"update_source_system_key" BIGINT   ENCODE zstd
	,"customer_preferred_interest_id" BIGINT   ENCODE zstd
	,"interest_type_id" BIGINT   ENCODE zstd
	,"interest_type_dscr" VARCHAR(100)   ENCODE zstd
	,"parent_interest_type_id" BIGINT   ENCODE zstd
	,"parent_interest_type_dscr" VARCHAR(100)   ENCODE zstd
	,"interest_dt" DATE   ENCODE zstd
	,"comment_txt" VARCHAR(16000)   ENCODE zstd
	,"calendar_type_id" SMALLINT   ENCODE zstd
	,"calendar_type_dscr" VARCHAR(100)   ENCODE zstd
	,"value_id" SMALLINT   ENCODE zstd
	,"value_dscr" VARCHAR(25)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"source_updated_user" VARCHAR(20)   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_date_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_date_dim"
(
	"source_date_key" BIGINT   ENCODE zstd
	,"date_yyyy_nbr" SMALLINT   ENCODE lzo
	,"date_month_txt" VARCHAR(15)   ENCODE zstd
	,"date_day_txt" VARCHAR(18)   ENCODE zstd
	,"date_year_454_txt" VARCHAR(18)   ENCODE zstd
	,"date_month_454_txt" VARCHAR(18)   ENCODE zstd
	,"date_week_454_txt" VARCHAR(16)   ENCODE zstd
	,"date_day_of_week_454_txt" VARCHAR(9)   ENCODE zstd
	,"date_fiscal_year_txt" VARCHAR(6)   ENCODE zstd
	,"date_fiscal_month_txt" VARCHAR(15)   ENCODE zstd
	,"date_fiscal_quarter_txt" VARCHAR(15)   ENCODE zstd
	,"date_holiday_season_ind" VARCHAR(1)   ENCODE lzo
	,"date_cymd_nbr" INTEGER   ENCODE lzo
	,"date_cc_nbr" SMALLINT   ENCODE lzo
	,"date_yy_nbr" SMALLINT   ENCODE lzo
	,"date_mm_nbr" SMALLINT   ENCODE lzo
	,"date_dd_nbr" SMALLINT   ENCODE lzo
	,"date_mips_week_454_txt" VARCHAR(16)   ENCODE zstd
	,"date_dt" DATE   ENCODE lzo
	,"date_julian_calendar_nbr" INTEGER   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_delivery_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_delivery_dim"
(
	"source_delivery_id" BIGINT   ENCODE lzo
	,"delivery_total_amt" NUMERIC(20,5)   ENCODE zstd
	,"delivery_delay_extraction_nbr" NUMERIC(20,5)   ENCODE zstd
	,"delivery_duration_nbr" NUMERIC(20,5)   ENCODE zstd
	,"delivery_retry_period_nbr" NUMERIC(20,5)   ENCODE zstd
	,"delivery_fcp_ind" SMALLINT   ENCODE lzo
	,"delivery_email_attachment_ind" SMALLINT   ENCODE lzo
	,"delivery_delaid_ind" SMALLINT   ENCODE lzo
	,"delivery_built_in_template_ind" SMALLINT   ENCODE lzo
	,"delivery_delete_status_ind" SMALLINT   ENCODE lzo
	,"delivery_message_type_cd" SMALLINT   ENCODE lzo
	,"delivery_message_type_dscr" VARCHAR(20)   ENCODE lzo
	,"delivery_model_ind" SMALLINT   ENCODE lzo
	,"delivery_mirror_page_usage_ind" SMALLINT   ENCODE lzo
	,"delivery_status_cd" SMALLINT   ENCODE lzo
	,"delivery_status_dscr" VARCHAR(50)   ENCODE zstd
	,"delivery_use_budget_validation_ind" SMALLINT   ENCODE lzo
	,"delivery_use_content_validation_ind" SMALLINT   ENCODE lzo
	,"delivery_use_extraction_validation_ind" SMALLINT   ENCODE lzo
	,"delivery_use_fcp_validation_ind" SMALLINT   ENCODE lzo
	,"delivery_use_target_validation_ind" SMALLINT   ENCODE lzo
	,"delivery_online_resource_purged_ind" SMALLINT   ENCODE lzo
	,"delivery_collection_nm" VARCHAR(1020)   ENCODE lzo
	,"delivery_country_cd" VARCHAR(100)   ENCODE lzo
	,"delivery_country_dscr" VARCHAR(400)   ENCODE lzo
	,"delivery_creative_content_cd" VARCHAR(1020)   ENCODE lzo
	,"delivery_creative_content_dscr" VARCHAR(1020)   ENCODE lzo
	,"delivery_creative_format_cd" VARCHAR(256)   ENCODE lzo
	,"delivery_creative_format_dscr" VARCHAR(256)   ENCODE lzo
	,"delivery_creative_layout_cd" VARCHAR(1020)   ENCODE lzo
	,"delivery_creative_layout_dscr" VARCHAR(1020)   ENCODE lzo
	,"delivery_creative_version_nm" VARCHAR(256)   ENCODE lzo
	,"delivery_cd" VARCHAR(200)   ENCODE lzo
	,"delivery_code_dscr" VARCHAR(200)   ENCODE zstd
	,"delivery_dscr" VARCHAR(2048)   ENCODE lzo
	,"delivery_event_type_cd" VARCHAR(1020)   ENCODE lzo
	,"delivery_event_type_dscr" VARCHAR(1020)   ENCODE lzo
	,"delivery_internal_nm" VARCHAR(400)   ENCODE zstd
	,"delivery_ip_affinity_cd" VARCHAR(100)   ENCODE lzo
	,"delivery_ip_affinity_dscr" VARCHAR(100)   ENCODE lzo
	,"delivery_job_type" VARCHAR(128)   ENCODE lzo
	,"delivery_label_txt" VARCHAR(512)   ENCODE zstd
	,"delivery_media_type" VARCHAR(1020)   ENCODE lzo
	,"delivery_nature_nm" VARCHAR(256)   ENCODE lzo
	,"delivery_product_type" VARCHAR(1020)   ENCODE lzo
	,"delivery_promotion_period_txt" VARCHAR(256)   ENCODE lzo
	,"delivery_promotion_theme_txt" VARCHAR(1020)   ENCODE lzo
	,"delivery_utm_campaign_nm" VARCHAR(160)   ENCODE lzo
	,"delivery_utm_campaign_medium_nm" VARCHAR(96)   ENCODE lzo
	,"delivery_utm_campaign_content_txt" VARCHAR(96)   ENCODE lzo
	,"delivery_utm_campaign_src_nm" VARCHAR(96)   ENCODE lzo
	,"delivery_validation_mode_cd" VARCHAR(100)   ENCODE lzo
	,"delivery_validation_mode_dscr" VARCHAR(100)   ENCODE lzo
	,"delivery_broad_start_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_broad_end_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_contact_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_content_modification_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_content_approval_deadline_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_extraction_file_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_tracked_from_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_tracked_to_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"delivery_source_proofed_delivery_id" BIGINT   ENCODE lzo
	,"delivery_processed_cnt" BIGINT   ENCODE lzo
	,"source_operation_id" BIGINT   ENCODE zstd
	,"operation_builin_ind" SMALLINT   ENCODE lzo
	,"operation_job_template_ind" SMALLINT   ENCODE lzo
	,"operation_use_budget_ind" SMALLINT   ENCODE lzo
	,"operation_use_budget_validation_ind" SMALLINT   ENCODE lzo
	,"operation_use_content_validation_ind" SMALLINT   ENCODE lzo
	,"operation_use_extraction_validation_ind" SMALLINT   ENCODE lzo
	,"operation_country_nm" VARCHAR(80)   ENCODE lzo
	,"operation_country_dscr" VARCHAR(400)   ENCODE zstd
	,"operation_internal_nm" VARCHAR(256)   ENCODE zstd
	,"operation_label_txt" VARCHAR(512)   ENCODE zstd
	,"operation_start_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"operation_end_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"operation_last_computed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"operation_budget_status_cd" SMALLINT   ENCODE lzo
	,"operation_budget_status_dscr" VARCHAR(20)   ENCODE zstd
	,"operation_cancel_state_cd" SMALLINT   ENCODE lzo
	,"operation_cancel_state_dscr" VARCHAR(20)   ENCODE zstd
	,"operation_commitment_level_cd" SMALLINT   ENCODE lzo
	,"operation_commitment_level_dscr" VARCHAR(25)   ENCODE zstd
	,"operation_complexity_cd" SMALLINT   ENCODE lzo
	,"operation_complexity_dscr" VARCHAR(25)   ENCODE zstd
	,"operation_computation_state_cd" SMALLINT   ENCODE lzo
	,"operation_computation_state_dscr" VARCHAR(25)   ENCODE zstd
	,"operation_message_type_cd" SMALLINT   ENCODE lzo
	,"operation_message_type_dscr" VARCHAR(50)   ENCODE zstd
	,"operation_nature_nm" VARCHAR(256)   ENCODE lzo
	,"operation_nature_dscr" VARCHAR(256)   ENCODE lzo
	,"operation_type_cd" SMALLINT   ENCODE lzo
	,"operation_type_dscr" VARCHAR(15)   ENCODE zstd
	,"operation_validation_mode_cd" SMALLINT   ENCODE lzo
	,"operation_validation_mode_dscr" VARCHAR(50)   ENCODE zstd
	,"operation_sandbox_mode_cd" SMALLINT   ENCODE lzo
	,"operation_sandbox_mode_dscr" VARCHAR(100)   ENCODE zstd
	,"operation_occasion_nm" VARCHAR(100)   ENCODE lzo
	,"operation_occasion_dscr" VARCHAR(100)   ENCODE lzo
	,"operation_theme_nm" VARCHAR(100)   ENCODE lzo
	,"operation_theme_dscr" VARCHAR(100)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_delivery_segment_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_delivery_segment_dim"
(
	"delivery_id" BIGINT   ENCODE lzo
	,"delivery_segment_cd" VARCHAR(50)   ENCODE lzo
	,"control_ind" SMALLINT   ENCODE lzo
	,"treated_ind" SMALLINT   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_dwpsaleh_email_delivery_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_dwpsaleh_email_delivery_fact"
(
	"sl_unique_key" BIGINT   ENCODE zstd
	,"source_customer_key" BIGINT   ENCODE zstd
	,"source_channel_key" BIGINT   ENCODE zstd
	,"source_product_key" BIGINT   ENCODE zstd
	,"invoice_date_key" BIGINT   ENCODE zstd
	,"invoice_nbr" VARCHAR(15)   ENCODE zstd
	,"line_nbr" INTEGER   ENCODE zstd
	,"number_of_units_qty" BIGINT   ENCODE zstd
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"has_units_ind" INTEGER   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"source_customer_key"
	, "source_channel_key"
	, "source_product_key"
	, "has_units_ind"
	)
;
--DROP TABLE "edh"."stg_ecm_emptask";
CREATE TABLE IF NOT EXISTS "edh"."stg_ecm_emptask"
(
	"taskid" BIGINT   
	,"tasktypeid" BIGINT   ENCODE lzo
	,"task_type_desc" VARCHAR(255)   ENCODE lzo
	,"taskoutcomeid" BIGINT   ENCODE lzo
	,"task_outcome_short_desc" VARCHAR(255)   ENCODE lzo
	,"task_outcome_long_desc" VARCHAR(255)   ENCODE lzo
	,"customerid" BIGINT   ENCODE lzo
	,"sourcecountryid" BIGINT   ENCODE lzo
	,"iscomplete" BIGINT   ENCODE lzo
	,"title" VARCHAR(1000)   ENCODE lzo
	,"description" VARCHAR(1000)   ENCODE lzo
	,"comment" VARCHAR(4000)   ENCODE lzo
	,"employeeno" BIGINT   ENCODE lzo
	,"storeno" BIGINT   ENCODE lzo
	,"createdby" VARCHAR(20)   ENCODE lzo
	,"modifiedby" VARCHAR(20)   ENCODE lzo
	,"reviewedby" VARCHAR(20)   ENCODE lzo
	,"priority" BIGINT   ENCODE lzo
	,"datereminder" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"reminderduration" BIGINT   ENCODE lzo
	,"datedue" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"datecompleted" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_datecreated" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_datelastmodified" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"customercontactreasoncodeid" NUMERIC(6,0)   ENCODE lzo
	,"customercontactreasoncode_desc" VARCHAR(255)   ENCODE lzo
	,"taskinitiativetypeid" BIGINT   ENCODE lzo
	,"tskinitiativetype_desc" VARCHAR(255)   ENCODE lzo
	,"rcd_actn_ind" VARCHAR(255)   ENCODE lzo
	,"rcd_change_tm" VARCHAR(255)   ENCODE lzo
	,"mapping_nm" VARCHAR(255)   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,"date_created" TIMESTAMP WITHOUT TIME ZONE   
	,"date_updated" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("taskid")
SORTKEY (
	"taskid"
	, "date_created"
	)
;
--DROP TABLE "edh"."stg_epd_currency_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_epd_currency_dim"
(
	"currency_cd" VARCHAR(3)   ENCODE lzo
	,"currency_nm" VARCHAR(100)   ENCODE lzo
	,"currency_symbol_txt" VARCHAR(40)   ENCODE lzo
	,"unidec01_nbr" SMALLINT   ENCODE lzo
	,"unidec02_nbr" SMALLINT   ENCODE lzo
	,"unidec03_nbr" SMALLINT   ENCODE lzo
	,"unidec04_nbr" SMALLINT   ENCODE lzo
	,"unihex01_nbr" VARCHAR(80)   ENCODE lzo
	,"unihex02_nbr" VARCHAR(80)   ENCODE lzo
	,"unihex03_nbr" VARCHAR(80)   ENCODE lzo
	,"unihex04_nbr" VARCHAR(80)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expire_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_experian_aus_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_experian_aus_customer_dim"
(
	"customer_key" BIGINT   ENCODE zstd
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"mosaic_group_nm" VARCHAR(255)   ENCODE zstd
	,"mosaic_type_group_cd" VARCHAR(20)   ENCODE bytedict
	,"mosaic_type_group_dscr" VARCHAR(255)   ENCODE zstd
	,"age_cd" VARCHAR(20)   ENCODE zstd
	,"age_cd_dscr" VARCHAR(255)   ENCODE zstd
	,"household_income_cd" VARCHAR(25)   ENCODE zstd
	,"household_income_cd_dscr" VARCHAR(25)   ENCODE bytedict
	,"children_aged_0_11_qty" SMALLINT   ENCODE lzo
	,"children_aged_11_18_qty" SMALLINT   ENCODE lzo
	,"household_relationship_group_cd" VARCHAR(20)   ENCODE zstd
	,"household_relationship_group_cd_dscr" VARCHAR(255)   ENCODE zstd
	,"gender_dscr" VARCHAR(20)   ENCODE zstd
	,"occupation_dscr" VARCHAR(255)   ENCODE zstd
	,"model_generated_decimal_nbr" NUMERIC(20,5)   ENCODE zstd
	,"model_generated_decimal_val" NUMERIC(10,6)   ENCODE bytedict
	,"factor_4_wealth_score_nbr" BIGINT   ENCODE mostly16
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_experian_uk_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_experian_uk_customer_dim"
(
	"customer_key" BIGINT   ENCODE zstd
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"gender_cd" VARCHAR(1)   ENCODE zstd
	,"gender_dscr" VARCHAR(15)   ENCODE zstd
	,"person_age_line_cd" VARCHAR(2)   ENCODE zstd
	,"person_age_line_dscr" VARCHAR(15)   ENCODE zstd
	,"household_income_band_cd" CHAR(1)   ENCODE zstd
	,"household_income_band_dscr" VARCHAR(40)   ENCODE zstd
	,"net_worth_level_cd" VARCHAR(1)   ENCODE zstd
	,"net_worth_level_dscr" VARCHAR(15)   ENCODE zstd
	,"marital_status_cd" CHAR(25)   ENCODE zstd
	,"marital_status_dscr" VARCHAR(20)   ENCODE zstd
	,"person_mosaic_shopper_type_cd" CHAR(3)   ENCODE zstd
	,"person_mosaic_shopper_type_dscr" VARCHAR(25)   ENCODE bytedict
	,"household_mosaic_uk_6_group_cd" CHAR(1)   ENCODE zstd
	,"household_mosaic_uk_6_group_dscr" VARCHAR(50)   ENCODE zstd
	,"household_mosaic_uk_6_type_cd" CHAR(2)   ENCODE zstd
	,"household_mosaic_uk_6_type_dscr" VARCHAR(50)   ENCODE zstd
	,"postcard_mosaic_uk_6_group_cd" CHAR(1)   ENCODE zstd
	,"postcard_mosaic_uk_6_group_dscr" VARCHAR(50)   ENCODE zstd
	,"postcard_mosaic_uk_6_type_cd" CHAR(2)   ENCODE zstd
	,"postcard_mosaic_uk_6_type_dscr" VARCHAR(50)   ENCODE zstd
	,"experian_person_key" NUMERIC(10,0)   ENCODE lzo
	,"experian_household_key" NUMERIC(19,0)   ENCODE lzo
	,"new_age_band" VARCHAR(20)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_inv_balance_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_inv_balance_fact"
(
	"oh_qty_amt" NUMERIC(20,5)   ENCODE lzo
	,"product_key" BIGINT NOT NULL  
	,"channel_key" BIGINT NOT NULL  
	,"inv_location_key" BIGINT NOT NULL  
	,"inv_balance_dt_key" BIGINT NOT NULL  
	,"source_system_key" BIGINT NOT NULL  
	,"itm_rtl_price_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_rtl_price_usd" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_usd" NUMERIC(20,5)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"supply_type" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE EVEN
SORTKEY (
	"inv_balance_dt_key"
	, "product_key"
	, "channel_key"
	, "inv_location_key"
	, "source_system_key"
	)
;
--DROP TABLE "edh"."stg_inv_recn_jdee1_to_geo_aggr";
CREATE TABLE IF NOT EXISTS "edh"."stg_inv_recn_jdee1_to_geo_aggr"
(
	"jdee1_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"geo_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_geo_var_age" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_geo_var_qty" NUMERIC(20,5)   ENCODE lzo
	,"product_key" BIGINT NOT NULL  
	,"channel_key" BIGINT NOT NULL  
	,"inv_location_key" BIGINT NOT NULL  
	,"itm_rtl_price_lc" NUMERIC(20,5)   ENCODE lzo
	,"inv_recn_rpt_dt_key" BIGINT NOT NULL  
	,"e1_to_geo_var_id_dt_key" BIGINT   ENCODE lzo
	,"itm_rtl_price_usd" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_usd" NUMERIC(20,5)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
SORTKEY (
	"inv_recn_rpt_dt_key"
	, "product_key"
	, "channel_key"
	, "inv_location_key"
	)
;
--DROP TABLE "edh"."stg_inv_recn_jdee1_to_strlg_aggr";
CREATE TABLE IF NOT EXISTS "edh"."stg_inv_recn_jdee1_to_strlg_aggr"
(
	"jdee1_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"strlg_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_strlg_var_age" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_strlg_var_qty" NUMERIC(20,5)   ENCODE lzo
	,"product_key" BIGINT NOT NULL  
	,"channel_key" BIGINT NOT NULL  
	,"inv_location_key" BIGINT NOT NULL  
	,"inv_recn_rpt_dt_key" BIGINT NOT NULL  
	,"e1_to_strlg_var_id_dt_key" BIGINT   ENCODE lzo
	,"itm_rtl_price_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_rtl_price_usd" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_usd" NUMERIC(20,5)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
SORTKEY (
	"inv_recn_rpt_dt_key"
	, "product_key"
	, "channel_key"
	, "inv_location_key"
	)
;
--DROP TABLE "edh"."stg_inv_recn_jdee1_to_strlg_aggr_store_level";
CREATE TABLE IF NOT EXISTS "edh"."stg_inv_recn_jdee1_to_strlg_aggr_store_level"
(
	"jdee1_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"strlg_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_strlg_var_age" NUMERIC(20,5)   ENCODE lzo
	,"e1_to_strlg_var_qty" NUMERIC(20,5)   ENCODE lzo
	,"product_key" BIGINT NOT NULL  ENCODE delta32k
	,"channel_key" BIGINT NOT NULL  ENCODE bytedict
	,"inv_recn_rpt_dt_key" BIGINT NOT NULL  ENCODE lzo
	,"e1_to_strlg_var_id_dt_key" BIGINT   ENCODE lzo
	,"itm_rtl_price_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_rtl_price_usd" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_usd" NUMERIC(20,5)   ENCODE mostly32
	,"mapping_nm" VARCHAR(100) NOT NULL  ENCODE runlength
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,PRIMARY KEY (inv_recn_rpt_dt_key, product_key, channel_key)
)
DISTSTYLE EVEN
SORTKEY (
	"inv_recn_rpt_dt_key"
	, "product_key"
	, "channel_key"
	)
;
--DROP TABLE "edh"."stg_inv_recn_strlg_to_geo_aggr";
CREATE TABLE IF NOT EXISTS "edh"."stg_inv_recn_strlg_to_geo_aggr"
(
	"jdee1_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"geo_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"strlg_oh_qty" NUMERIC(20,5)   ENCODE lzo
	,"strlg_to_geo_var_age" NUMERIC(20,5)   ENCODE lzo
	,"strlg_to_geo_var_qty" NUMERIC(20,5)   ENCODE lzo
	,"product_key" BIGINT NOT NULL  
	,"channel_key" BIGINT NOT NULL  
	,"supply_type" VARCHAR(100) NOT NULL  
	,"itm_rtl_price_lc" NUMERIC(20,5)   ENCODE lzo
	,"inv_recn_rpt_dt_key" BIGINT NOT NULL  
	,"strlg_to_geo_var_id_dt_key" BIGINT   ENCODE lzo
	,"itm_rtl_price_usd" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_lc" NUMERIC(20,5)   ENCODE lzo
	,"itm_cost_usd" NUMERIC(20,5)   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_ts" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
SORTKEY (
	"inv_recn_rpt_dt_key"
	, "product_key"
	, "channel_key"
	, "supply_type"
	)
;
--DROP TABLE "edh"."stg_market_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_market_dim"
(
	"iso_2_char_country_cd" VARCHAR(2)   ENCODE lzo
	,"iso_3_char_country_cd" VARCHAR(3)   ENCODE lzo
	,"iso_numeric_country_cd" SMALLINT   ENCODE lzo
	,"english_label_txt" VARCHAR(80)   ENCODE lzo
	,"local_currency_cd" VARCHAR(3)   ENCODE lzo
	,"market_region_nm" VARCHAR(25)   ENCODE lzo
	,"market_display_nm" VARCHAR(25)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_millward_brown_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_millward_brown_customer_dim"
(
	"customer_key" BIGINT   ENCODE zstd
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"primary_segment_cd" VARCHAR(5)   ENCODE zstd
	,"primary_segment_dscr" VARCHAR(50)   ENCODE zstd
	,"secondary_segment_cd" VARCHAR(5)   ENCODE zstd
	,"secondary_segment_dscr" VARCHAR(50)   ENCODE zstd
	,"primary_segment_probability_rt" NUMERIC(10,6)   ENCODE zstd
	,"secondary_segment_probability_rt" NUMERIC(10,6)   ENCODE zstd
	,"rus_flg" VARCHAR(3)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_product_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_product_dim"
(
	"source_product_key" BIGINT   ENCODE zstd
	,"source_system_nm" VARCHAR(20)   ENCODE zstd
	,"sku_nbr" BIGINT   ENCODE zstd
	,"product_dscr" VARCHAR(35)   ENCODE zstd
	,"department_nbr" BIGINT   ENCODE zstd
	,"department_dscr" VARCHAR(30)   ENCODE bytedict
	,"class_nbr" BIGINT   ENCODE zstd
	,"class_dscr" VARCHAR(30)   ENCODE zstd
	,"style_nbr" BIGINT   ENCODE zstd
	,"style_dscr" VARCHAR(30)   ENCODE zstd
	,"mips_flg" CHAR(1)   ENCODE zstd
	,"product_type" VARCHAR(30)   ENCODE zstd
	,"product_type_group_nm" VARCHAR(30)   ENCODE zstd
	,"product_collection_nm" VARCHAR(30)   ENCODE zstd
	,"financial_product_category_nm" VARCHAR(40)   ENCODE zstd
	,"financial_product_group_nm" VARCHAR(30)   ENCODE zstd
	,"financial_product_family_nm" VARCHAR(30)   ENCODE bytedict
	,"financial_product_sub_family_nm" VARCHAR(30)   ENCODE bytedict
	,"financial_rollup_flg" CHAR(1)   ENCODE zstd
	,"financial_sort_order_nbr" SMALLINT   ENCODE zstd
	,"material_type" VARCHAR(30)   ENCODE zstd
	,"material_type_group_nm" VARCHAR(30)   ENCODE zstd
	,"primary_gem_content_nm" VARCHAR(30)   ENCODE zstd
	,"gem_color_nm" VARCHAR(5)   ENCODE zstd
	,"gem_clarity_nm" VARCHAR(5)   ENCODE zstd
	,"ir_flg" VARCHAR(1)   ENCODE zstd
	,"discontinued_flg" CHAR(1)   ENCODE zstd
	,"pyramid_flg" CHAR(1)   ENCODE zstd
	,"old_department_nbr" BIGINT   ENCODE zstd
	,"old_class_nbr" BIGINT   ENCODE zstd
	,"old_style_nbr" BIGINT   ENCODE zstd
	,"reclass_dt" DATE   ENCODE zstd
	,"jde_item_nbr" BIGINT   ENCODE zstd
	,"color_clarity_cd" VARCHAR(5)   ENCODE bytedict
	,"logility_item_cd" VARCHAR(18)   ENCODE zstd
	,"logility_color_cd" VARCHAR(2)   ENCODE zstd
	,"logility_clarity_cd" VARCHAR(3)   ENCODE zstd
	,"logility_status_cd" VARCHAR(2)   ENCODE zstd
	,"logility_flg" VARCHAR(1)   ENCODE zstd
	,"mfg_style" VARCHAR(12)   ENCODE zstd
	,"mips_size_dscr" VARCHAR(10)   ENCODE zstd
	,"mips_cons_cd" CHAR(1)   ENCODE zstd
	,"warehouse_only_flg" VARCHAR(1)   ENCODE zstd
	,"set_flg" VARCHAR(1)   ENCODE zstd
	,"product_lunch_dt" DATE   ENCODE zstd
	,"country_of_origin_cd" VARCHAR(8)   ENCODE zstd
	,"country_of_origin_nm" VARCHAR(100)   ENCODE zstd
	,"price_point_cd" VARCHAR(10)   ENCODE lzo
	,"price_point_dscr" VARCHAR(25)   ENCODE zstd
	,"abc_cd" VARCHAR(5)   ENCODE zstd
	,"rank_cd" VARCHAR(5)   ENCODE zstd
	,"unit_sales_cd" BIGINT   ENCODE zstd
	,"prime_sku_nbr" BIGINT   ENCODE zstd
	,"designer_cd" VARCHAR(10)   ENCODE zstd
	,"designer_dscr" VARCHAR(25)   ENCODE zstd
	,"source_last_updt_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"merchandise_collection_nm" VARCHAR(25)   ENCODE bytedict
	,"primary_gem_carat_weight" NUMERIC(8,2)   ENCODE zstd
	,"primary_gem_cut_txt" VARCHAR(30)   ENCODE zstd
	,"primary_gem_shape_txt" VARCHAR(30)   ENCODE zstd
	,"motif_dscr" VARCHAR(30)   ENCODE zstd
	,"mips_retail_price_amt" NUMERIC(20,5)   ENCODE zstd
	,"mips_average_cost_amt" NUMERIC(20,5)   ENCODE zstd
	,"mips_consigned_cost_amt" NUMERIC(20,5)   ENCODE zstd
	,"first_receipt_dt" DATE   ENCODE zstd
	,"maps_id" VARCHAR(15)   ENCODE zstd
	,"maps_dscr" VARCHAR(30)   ENCODE zstd
	,"cmrp_color_cd" VARCHAR(2)   ENCODE zstd
	,"cmrp_clarity_cd" VARCHAR(4)   ENCODE bytedict
	,"ring_width_milimeters_nbr" NUMERIC(8,2)   ENCODE zstd
	,"mips_current_cost_amt" NUMERIC(20,5)   ENCODE zstd
	,"primary_gem_group" VARCHAR(30)   ENCODE lzo
	,"seasonal_ind" VARCHAR(1)   ENCODE lzo
	,"epd_product_revised_merchandise_collection_nm" VARCHAR(200)   ENCODE lzo
	,"epd_product_type_tier_2_nm" VARCHAR(200)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_sales_history_fact";
CREATE TABLE IF NOT EXISTS "edh"."stg_sales_history_fact"
(
	"source_sales_history_key" BIGINT   ENCODE zstd
	,"clerk_group_key" BIGINT   ENCODE zstd
	,"gl_date_key" BIGINT   ENCODE zstd
	,"invoice_date_key" BIGINT   ENCODE zstd
	,"order_date_key" BIGINT   ENCODE zstd
	,"customer_key" BIGINT   ENCODE zstd
	,"product_key" BIGINT   ENCODE zstd
	,"channel_key" BIGINT   ENCODE zstd
	,"time_key" BIGINT   ENCODE zstd
	,"tourism_key" BIGINT   ENCODE zstd
	,"transaction_key" BIGINT   ENCODE zstd
	,"number_of_units_qty" BIGINT   ENCODE zstd
	,"extended_price_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"extended_cost_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"unit_price_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"unit_cost_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"tax_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"discount_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"discount_percent_rt" NUMERIC(10,6)   ENCODE zstd
	,"extended_price_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"extended_cost_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"unit_price_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"unit_cost_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"tax_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"discount_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"extended_unit_price_usd_amt" NUMERIC(20,5)   ENCODE zstd
	,"extended_unit_price_local_currency_amt" NUMERIC(20,5)   ENCODE zstd
	,"store_nbr" BIGINT   ENCODE zstd
	,"channel_cd" VARCHAR(2)   ENCODE zstd
	,"invoice_nbr" VARCHAR(15)   ENCODE zstd
	,"line_nbr" BIGINT   ENCODE zstd
	,"recipient_cd" VARCHAR(20)   ENCODE zstd
	,"department_nbr" BIGINT   ENCODE zstd
	,"class_nbr" BIGINT   ENCODE zstd
	,"date_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"commisionable_sale_ind" SMALLINT   ENCODE lzo
	,"zero_transaction_ind" SMALLINT   ENCODE zstd
	,"gift_item_cd" CHAR(1)   ENCODE zstd
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_source_system_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_source_system_dim"
(
	"source_system_id" BIGINT   ENCODE lzo
	,"source_system_short_dscr" VARCHAR(100)   ENCODE lzo
	,"source_system_long_dscr" VARCHAR(200)   ENCODE lzo
	,"source_system_country_display_nm" VARCHAR(100)   ENCODE lzo
	,"source_system_country_iso_cd" VARCHAR(2)   ENCODE lzo
	,"source_system_country_iso_nm" VARCHAR(100)   ENCODE lzo
	,"source_created_timestamp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"source_updated_timestamp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_subscription_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_subscription_dim"
(
	"customer_key" BIGINT   ENCODE zstd
	,"service_id" BIGINT   ENCODE zstd
	,"service_label_txt" VARCHAR(512)   ENCODE zstd
	,"service_nm" VARCHAR(256)   ENCODE zstd
	,"subscription_control_ind" SMALLINT   ENCODE zstd
	,"recipient_id" BIGINT   ENCODE zstd
	,"engagement_ready_to_send_ind" SMALLINT   ENCODE zstd
	,"cohort_cd" VARCHAR(100)   ENCODE zstd
	,"cohort_dscr" VARCHAR(100)   ENCODE zstd
	,"log_txt" VARCHAR(400)   ENCODE zstd
	,"phase_txt" VARCHAR(200)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"entered_cohord_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"householding_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"left_cohort_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"subscription_transaction_id" BIGINT   ENCODE zstd
	,"subscription_transaction_invoice_nbr" VARCHAR(60)   ENCODE zstd
	,"delete_status_cd" SMALLINT   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_time_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_time_dim"
(
	"source_time_key" BIGINT   ENCODE lzo
	,"from_time_nbr" SMALLINT   ENCODE lzo
	,"to_time_nbr" SMALLINT   ENCODE lzo
	,"time_slot_txt" VARCHAR(30)   ENCODE lzo
	,"time_hour_txt" VARCHAR(30)   ENCODE lzo
	,"day_part_nm" VARCHAR(25)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_tourism_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_tourism_dim"
(
	"tourism_type" VARCHAR(10)   ENCODE lzo
	,"tourism_type_dscr" VARCHAR(100)   ENCODE lzo
	,"country_of_origin_cd" VARCHAR(3)   ENCODE lzo
	,"country_of_origin_dscr" VARCHAR(60)   ENCODE lzo
	,"country_tourism_cd" VARCHAR(3)   ENCODE lzo
	,"country_tourism_dscr" VARCHAR(60)   ENCODE lzo
	,"regional_tourism_cd" VARCHAR(3)   ENCODE lzo
	,"regional_tourism_dscr" VARCHAR(60)   ENCODE lzo
	,"executive_tourism_cd" VARCHAR(3)   ENCODE lzo
	,"executive_tourism_dscr" VARCHAR(60)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_transaction_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_transaction_dim"
(
	"transaction_type_cd" VARCHAR(5)   ENCODE lzo
	,"transaction_type_dscr" VARCHAR(25)   ENCODE lzo
	,"include_in_flash_ind" VARCHAR(1)   ENCODE lzo
	,"include_in_product_ind" VARCHAR(1)   ENCODE lzo
	,"employee_transaction_ind" VARCHAR(1)   ENCODE lzo
	,"cost_adjustment_ind" VARCHAR(1)   ENCODE lzo
	,"unassigned_return_ind" VARCHAR(1)   ENCODE lzo
	,"store_pickup_ind" VARCHAR(1)   ENCODE lzo
	,"return_reason_cd" VARCHAR(6)   ENCODE lzo
	,"return_reason_dscr" VARCHAR(40)   ENCODE lzo
	,"credit_status_nbr" VARCHAR(2)   ENCODE lzo
	,"event_cd" VARCHAR(6)   ENCODE lzo
	,"event_dscr" VARCHAR(40)   ENCODE lzo
	,"distribution_cd" VARCHAR(2)   ENCODE lzo
	,"distribution_dscr" VARCHAR(25)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."stg_usr_actionitems";
CREATE TABLE IF NOT EXISTS "edh"."stg_usr_actionitems"
(
	"seq_num" INTEGER   ENCODE lzo
	,"actionitemid" BIGINT   
	,"actionitemtypeid" BIGINT   ENCODE lzo
	,"actionitemtypedesc" VARCHAR(100)   ENCODE lzo
	,"actionprioritytypeid" BIGINT   ENCODE lzo
	,"actionprioritytypedesc" VARCHAR(100)   ENCODE lzo
	,"outreachactionreasontypeid" BIGINT   ENCODE lzo
	,"outreachactionreasontypedesc" VARCHAR(100)   ENCODE lzo
	,"taskcustcontactrsncd" BIGINT   ENCODE lzo
	,"outreachactionmethodtypeid" BIGINT   ENCODE lzo
	,"outreachactionmethodtypedesc" VARCHAR(100)   ENCODE lzo
	,"taskoutcomemethodtypeid" BIGINT   ENCODE lzo
	,"customerid" BIGINT   ENCODE lzo
	,"sourcecountryid" BIGINT   ENCODE lzo
	,"sourcecountryshortdesc" VARCHAR(100)   ENCODE lzo
	,"createdemployeenumber" BIGINT   ENCODE lzo
	,"assignedemployeenumber" BIGINT   ENCODE lzo
	,"associatedstorenumber" BIGINT   ENCODE lzo
	,"createdby" VARCHAR(20)   ENCODE lzo
	,"modifiedby" VARCHAR(20)   ENCODE lzo
	,"reviewedby" VARCHAR(20)   ENCODE lzo
	,"duedatetime" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"datecompleted" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"datecreated" TIMESTAMP WITHOUT TIME ZONE   
	,"datelastmodified" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"actionstatustypeid" BIGINT   ENCODE lzo
	,"actionstatustypedesc" VARCHAR(100)   ENCODE lzo
	,"actioninitiativetypeid" BIGINT   ENCODE lzo
	,"actioninitiativetypedesc" VARCHAR(100)   ENCODE lzo
	,"actiongifttypeid" BIGINT   ENCODE lzo
	,"actiongifttypedesc" VARCHAR(100)   ENCODE lzo
	,"giftsku" VARCHAR(20)   ENCODE lzo
	,"giftretailvalue" NUMERIC(38,5)   ENCODE lzo
	,"giftcountycode" VARCHAR(5)   ENCODE lzo
	,"consultationdatetime" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"giftdescription" VARCHAR(250)   ENCODE lzo
	,"contacttaskid" BIGINT   ENCODE lzo
	,"eventactionitemid" BIGINT   ENCODE lzo
	,"rcd_actn_ind" VARCHAR(1)   ENCODE lzo
	,"rcd_change_tm" VARCHAR(100)   ENCODE lzo
	,"stg_load_dt" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"stg_load_mapping_nm" VARCHAR(100)   ENCODE lzo
	,"stg_load_instance_id" VARCHAR(100)   ENCODE lzo
)
DISTSTYLE KEY
DISTKEY ("actionitemid")
SORTKEY (
	"actionitemid"
	, "datecreated"
	)
;
--DROP TABLE "edh"."stg_wealth_engine_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."stg_wealth_engine_customer_dim"
(
	"customer_key" BIGINT   ENCODE zstd
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"net_worth_amt" VARCHAR(20)   ENCODE bytedict
	,"household_income_amt" VARCHAR(20)   ENCODE bytedict
	,"birth_dt" VARCHAR(10)   ENCODE zstd
	,"gender_cd" CHAR(1)   ENCODE zstd
	,"gender_dscr" VARCHAR(20)   ENCODE zstd
	,"marital_status_cd" CHAR(1)   ENCODE zstd
	,"marital_status_dscr" VARCHAR(20)   ENCODE zstd
	,"p2g_score_nbr" VARCHAR(50)   ENCODE zstd
	,"non_profit_board_flg" VARCHAR(3)   ENCODE zstd
	,"retail_purchaser_flg" VARCHAR(1)   ENCODE zstd
	,"living_upscale_flg" VARCHAR(1)   ENCODE zstd
	,"sport_code_ss_rollup_flg" VARCHAR(1)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"operational_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."subscription_dim";
CREATE TABLE IF NOT EXISTS "edh"."subscription_dim"
(
	"subscription_key" BIGINT NOT NULL DEFAULT "identity"(395108, 0, '1,1'::text) ENCODE zstd
	,"customer_key" BIGINT   
	,"service_id" BIGINT   ENCODE zstd
	,"service_label_txt" VARCHAR(512)   ENCODE zstd
	,"service_nm" VARCHAR(256)   ENCODE zstd
	,"subscription_control_ind" SMALLINT   ENCODE zstd
	,"recipient_id" BIGINT   ENCODE zstd
	,"engagement_ready_to_send_ind" SMALLINT   ENCODE zstd
	,"cohort_cd" VARCHAR(100)   ENCODE zstd
	,"cohort_dscr" VARCHAR(100)   ENCODE zstd
	,"log_txt" VARCHAR(400)   ENCODE zstd
	,"phase_txt" VARCHAR(200)   ENCODE zstd
	,"source_create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"entered_cohord_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"householding_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"left_cohort_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"subscription_transaction_id" BIGINT   ENCODE zstd
	,"subscription_transaction_invoice_nbr" VARCHAR(60)   ENCODE zstd
	,"delete_status_cd" SMALLINT   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (subscription_key)
)
DISTSTYLE KEY
DISTKEY ("customer_key")
INTERLEAVED SORTKEY (
	"customer_key"
	, "service_label_txt"
	, "cohort_cd"
	, "subscription_control_ind"
	)
;
--DROP TABLE "edh"."tco_campaign_reporting_deliveries";
CREATE TABLE IF NOT EXISTS "edh"."tco_campaign_reporting_deliveries"
(
	"seq_num" BIGINT NOT NULL  ENCODE lzo
	,"source_delivery_id" BIGINT NOT NULL  ENCODE lzo
	,"extract_tmstmp" VARCHAR(50)   ENCODE lzo
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."test_20190524";
CREATE TABLE IF NOT EXISTS "edh"."test_20190524"
(
	"sales_id" BIGINT   ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"delivery_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   ENCODE lzo
	,"sales_invoice_ecm_customer_id" BIGINT   ENCODE lzo
	,"source_customer_key" BIGINT   ENCODE lzo
	,"invoice_date_key" BIGINT   ENCODE lzo
	,"invoice_dt" DATE   ENCODE lzo
	,"invoice_nbr" VARCHAR(15)   ENCODE lzo
	,"line_nbr" INTEGER   ENCODE lzo
	,"match_type" INTEGER   ENCODE lzo
	,"source_channel_key" BIGINT   ENCODE lzo
	,"source_product_key" BIGINT   ENCODE lzo
	,"sales_units" INTEGER   ENCODE lzo
	,"sales_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"sales_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE EVEN
;
--DROP TABLE "edh"."time_dim";
CREATE TABLE IF NOT EXISTS "edh"."time_dim"
(
	"time_key" BIGINT NOT NULL DEFAULT "identity"(395113, 0, '1,1'::text) ENCODE lzo
	,"source_time_key" BIGINT NOT NULL  ENCODE lzo
	,"from_time_nbr" SMALLINT   ENCODE lzo
	,"to_time_nbr" SMALLINT   ENCODE lzo
	,"time_slot_txt" VARCHAR(30)   ENCODE lzo
	,"time_hour_txt" VARCHAR(30)   ENCODE lzo
	,"day_part_nm" VARCHAR(25)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (time_key)
)
DISTSTYLE ALL
;
--DROP TABLE "edh"."tourism_dim";
CREATE TABLE IF NOT EXISTS "edh"."tourism_dim"
(
	"tourism_key" BIGINT NOT NULL DEFAULT "identity"(395429, 0, '-999,1'::text) ENCODE lzo
	,"tourism_type" VARCHAR(10)   ENCODE lzo
	,"tourism_type_dscr" VARCHAR(100)   ENCODE lzo
	,"country_of_origin_cd" VARCHAR(3)   ENCODE lzo
	,"country_of_origin_dscr" VARCHAR(60)   ENCODE lzo
	,"country_tourism_cd" VARCHAR(3)   ENCODE lzo
	,"country_tourism_dscr" VARCHAR(60)   ENCODE lzo
	,"regional_tourism_cd" VARCHAR(3)   ENCODE lzo
	,"regional_tourism_dscr" VARCHAR(60)   ENCODE lzo
	,"executive_tourism_cd" VARCHAR(3)   ENCODE lzo
	,"executive_tourism_dscr" VARCHAR(60)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (tourism_key)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"tourism_type"
	, "regional_tourism_cd"
	, "regional_tourism_dscr"
	, "executive_tourism_cd"
	, "executive_tourism_dscr"
	)
;
--DROP TABLE "edh"."transaction_dim";
CREATE TABLE IF NOT EXISTS "edh"."transaction_dim"
(
	"transaction_key" BIGINT NOT NULL DEFAULT "identity"(395123, 0, '1,1'::text) ENCODE lzo
	,"transaction_type_cd" VARCHAR(5) NOT NULL  
	,"transaction_type_dscr" VARCHAR(25) NOT NULL  
	,"include_in_flash_ind" VARCHAR(1)   ENCODE lzo
	,"include_in_product_ind" VARCHAR(1)   ENCODE lzo
	,"employee_transaction_ind" VARCHAR(1)   
	,"cost_adjustment_ind" VARCHAR(1)   ENCODE lzo
	,"unassigned_return_ind" VARCHAR(1)   
	,"store_pickup_ind" VARCHAR(1)   ENCODE lzo
	,"return_reason_cd" VARCHAR(6)   ENCODE lzo
	,"return_reason_dscr" VARCHAR(40)   ENCODE lzo
	,"credit_status_nbr" VARCHAR(2)   ENCODE lzo
	,"event_cd" VARCHAR(6)   ENCODE lzo
	,"event_dscr" VARCHAR(40)   ENCODE lzo
	,"distribution_cd" VARCHAR(2)   ENCODE lzo
	,"distribution_dscr" VARCHAR(25)   ENCODE lzo
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,PRIMARY KEY (transaction_key)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"transaction_type_cd"
	, "transaction_type_dscr"
	, "employee_transaction_ind"
	, "unassigned_return_ind"
	)
;
--DROP TABLE "edh"."wealth_engine_customer_dim";
CREATE TABLE IF NOT EXISTS "edh"."wealth_engine_customer_dim"
(
	"customer_key" BIGINT NOT NULL  
	,"ecm_customer_id" BIGINT   ENCODE zstd
	,"net_worth_amt" VARCHAR(20)   ENCODE bytedict
	,"household_income_amt" VARCHAR(20)   ENCODE bytedict
	,"birth_dt" VARCHAR(10)   ENCODE zstd
	,"gender_cd" CHAR(1)   ENCODE zstd
	,"gender_dscr" VARCHAR(20)   ENCODE zstd
	,"marital_status_cd" CHAR(1)   ENCODE zstd
	,"marital_status_dscr" VARCHAR(20)   ENCODE zstd
	,"p2g_score_nbr" VARCHAR(50)   ENCODE zstd
	,"non_profit_board_flg" VARCHAR(3)   ENCODE zstd
	,"retail_purchaser_ind" VARCHAR(1)   ENCODE zstd
	,"living_upscale_ind" VARCHAR(1)   ENCODE zstd
	,"sport_code_ss_rollup_ind" VARCHAR(1)   ENCODE zstd
	,"effective_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"expiration_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"current_ind" SMALLINT   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE zstd
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE zstd
	,PRIMARY KEY (customer_key)
)
DISTSTYLE KEY
DISTKEY ("customer_key")
SORTKEY (
	"customer_key"
	)
;
--DROP TABLE "edh"."wrk_nmsbroadlogrcp";
CREATE TABLE IF NOT EXISTS "edh"."wrk_nmsbroadlogrcp"
(
	"broad_log_id" BIGINT NOT NULL  ENCODE delta
	,"delivery_id" BIGINT NOT NULL  ENCODE zstd
	,"recipient_id" BIGINT NOT NULL  ENCODE zstd
	,"email_address_txt" VARCHAR(2048)   ENCODE zstd
	,"segment_cd" VARCHAR(200)   ENCODE zstd
	,"ip_affinity_cd" INTEGER   ENCODE zstd
	,"message_id" BIGINT NOT NULL  ENCODE zstd
	,"flag_cd" INTEGER NOT NULL  ENCODE zstd
	,"service_id" BIGINT NOT NULL  ENCODE zstd
	,"status_cd" INTEGER NOT NULL  ENCODE zstd
	,"event_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"last_modified_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"sent_cnt" INTEGER   ENCODE zstd
	,"hard_bounce_cnt" INTEGER   ENCODE zstd
	,"soft_bounce_cnt" INTEGER   ENCODE zstd
	,"complaint_cnt" INTEGER   ENCODE zstd
	,"delivered_cnt" INTEGER   ENCODE zstd
	,"sent_date_key" BIGINT   ENCODE zstd
	,"bounced_date_key" BIGINT   ENCODE zstd
	,"delivered_date_key" BIGINT   ENCODE zstd
	,"processed_ind" INTEGER   ENCODE zstd
	,"processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE lzo
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,"complaint_date_key" BIGINT   ENCODE zstd
	,PRIMARY KEY (broad_log_id)
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"recipient_id"
	, "delivery_id"
	, "broad_log_id"
	, "processed_ind"
	, "email_address_txt"
	, "segment_cd"
	, "ip_affinity_cd"
	, "message_id"
	)
;
--DROP TABLE "edh"."wrk_nmstrackinglogrcp";
CREATE TABLE IF NOT EXISTS "edh"."wrk_nmstrackinglogrcp"
(
	"tracking_log_id" BIGINT NOT NULL  ENCODE zstd
	,"broad_log_id" BIGINT NOT NULL  ENCODE zstd
	,"delivery_id" BIGINT NOT NULL  ENCODE zstd
	,"recipient_id" BIGINT NOT NULL  ENCODE zstd
	,"url_id" BIGINT NOT NULL  ENCODE zstd
	,"type_ind" INTEGER   ENCODE zstd
	,"user_agent_cd" BIGINT   ENCODE zstd
	,"external_id_txt" VARCHAR(192)   ENCODE lzo
	,"source_id_txt" VARCHAR(192)   ENCODE zstd
	,"source_type_txt" VARCHAR(64)   ENCODE zstd
	,"log_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE zstd
	,"log_date_key" BIGINT   ENCODE zstd
	,"open_cnt" INTEGER   ENCODE zstd
	,"click_cnt" INTEGER   ENCODE zstd
	,"opt_out_cnt" INTEGER   ENCODE zstd
	,"open_date_key" BIGINT   ENCODE zstd
	,"click_date_key" BIGINT   ENCODE zstd
	,"opt_out_date_key" BIGINT   ENCODE lzo
	,"processed_ind" INTEGER   ENCODE zstd
	,"processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE zstd
	,PRIMARY KEY (tracking_log_id)
)
DISTSTYLE KEY
DISTKEY ("broad_log_id")
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "log_tmstmp"
	, "url_id"
	, "tracking_log_id"
	, "recipient_id"
	, "delivery_id"
	, "processed_ind"
	)
;
--DROP TABLE "edh"."wrk_nmswebtrackinglog";
CREATE TABLE IF NOT EXISTS "edh"."wrk_nmswebtrackinglog"
(
	"web_tracking_log_id" BIGINT NOT NULL  
	,"delivery_id" BIGINT NOT NULL  
	,"visitor_id" BIGINT NOT NULL  ENCODE lzo
	,"category_txt" VARCHAR(40)   ENCODE lzo
	,"confirmation_txt" VARCHAR(80)   ENCODE lzo
	,"direct_unit_cnt" INTEGER NOT NULL  ENCODE lzo
	,"direct_amt_local_currency" NUMERIC(20,5) NOT NULL  ENCODE lzo
	,"processed_ind" INTEGER NOT NULL  
	,"processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"mapping_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE  DEFAULT ('now'::character varying)::timestamp without time zone ENCODE zstd
	,"workflow_instance_id" VARCHAR(100)   ENCODE lzo
	,"row_type" VARCHAR(1)   ENCODE lzo
	,PRIMARY KEY (web_tracking_log_id)
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"web_tracking_log_id"
	, "processed_ind"
	, "delivery_id"
	)
;
--DROP TABLE "edh"."wrk_sales";
CREATE TABLE IF NOT EXISTS "edh"."wrk_sales"
(
	"sales_id" BIGINT NOT NULL DEFAULT "identity"(395150, 0, '1,1'::text) ENCODE lzo
	,"operation_id" BIGINT   ENCODE lzo
	,"delivery_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE lzo
	,"broad_log_id" BIGINT   
	,"sales_invoice_ecm_customer_id" BIGINT   ENCODE lzo
	,"source_customer_key" BIGINT   ENCODE lzo
	,"invoice_date_key" BIGINT   
	,"invoice_dt" DATE   ENCODE lzo
	,"invoice_nbr" VARCHAR(15)   
	,"line_nbr" INTEGER   ENCODE lzo
	,"match_type" INTEGER   ENCODE lzo
	,"source_channel_key" BIGINT   ENCODE lzo
	,"source_product_key" BIGINT   ENCODE lzo
	,"sales_units" INTEGER   ENCODE lzo
	,"sales_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"sales_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "invoice_nbr"
	, "invoice_date_key"
	)
;
--DROP TABLE "edh"."wrk_salesinvoice";
CREATE TABLE IF NOT EXISTS "edh"."wrk_salesinvoice"
(
	"sales_invoice_id" BIGINT NOT NULL DEFAULT "identity"(395153, 0, '1,1'::text) ENCODE delta
	,"ecm_customer_id" BIGINT   ENCODE lzo
	,"source_customer_key" BIGINT   
	,"invoice_nbr" VARCHAR(15)   
	,"display_country_nm" VARCHAR(100)   ENCODE lzo
	,"currency_cd" VARCHAR(3)   ENCODE lzo
	,"is_retail_channel_ind" INTEGER   ENCODE lzo
	,"min_invoice_date_key" BIGINT   ENCODE delta32k
	,"max_invoice_date_key" BIGINT   ENCODE delta32k
	,"min_invoice_dt" DATE   ENCODE lzo
	,"max_invoice_dt" DATE   ENCODE lzo
	,"sales_invoice_units" INTEGER   ENCODE lzo
	,"sales_invoice_local_currency_amt" NUMERIC(20,5)   ENCODE lzo
	,"sales_invoice_usd_amt" NUMERIC(20,5)   ENCODE lzo
	,"to_tpx_processed_ind" INTEGER   ENCODE lzo
	,"to_tpx_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"sales_invoice_id"
	, "invoice_nbr"
	, "source_customer_key"
	, "min_invoice_date_key"
	)
;
--DROP TABLE "edh"."wrk_trackingpixel";
CREATE TABLE IF NOT EXISTS "edh"."wrk_trackingpixel"
(
	"tracking_pixel_id" BIGINT NOT NULL DEFAULT "identity"(395156, 0, '1,1'::text) ENCODE delta32k
	,"log_date_key" BIGINT   ENCODE delta32k
	,"log_dt" DATE   ENCODE lzo
	,"broad_log_id" BIGINT   ENCODE mostly32
	,"operation_id" BIGINT   ENCODE lzo
	,"delivery_id" BIGINT   ENCODE lzo
	,"recipient_id" BIGINT   ENCODE mostly32
	,"ecm_customer_id" BIGINT   ENCODE mostly32
	,"email_address_txt" VARCHAR(2048)   ENCODE lzo
	,"sales_invoice_id" BIGINT   ENCODE mostly32
	,"attributed_unit_cnt" INTEGER   ENCODE lzo
	,"attributed_amt_local_currency" NUMERIC(20,5)   ENCODE lzo
	,"attributed_amt_usd" NUMERIC(20,5)   ENCODE lzo
	,"attributed_amt_gbp" NUMERIC(20,5)   ENCODE lzo
	,"attribution_type" VARCHAR(15)   ENCODE lzo
	,"to_edf_processed_ind" SMALLINT   ENCODE lzo
	,"to_edf_processed_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"broad_log_id"
	, "tracking_pixel_id"
	, "recipient_id"
	, "delivery_id"
	, "attributed_unit_cnt"
	, "email_address_txt"
	)
;
--DROP TABLE "edh"."wrk_trackingpixelinvoice";
CREATE TABLE IF NOT EXISTS "edh"."wrk_trackingpixelinvoice"
(
	"tracking_pixel_invoice_id" BIGINT NOT NULL DEFAULT "identity"(395159, 0, '1,1'::text) ENCODE lzo
	,"tracking_pixel_id" BIGINT NOT NULL  
	,"sales_invoice_id" BIGINT NOT NULL  
	,"tracking_pixel_ecm_customer_id" BIGINT   ENCODE lzo
	,"sales_invoice_ecm_customer_id" BIGINT   ENCODE lzo
	,"match_type" INTEGER   ENCODE lzo
	,"is_match_revenue_ind" INTEGER   ENCODE lzo
	,"script_nm" VARCHAR(100)   ENCODE lzo
	,"create_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
	,"update_tmstmp" TIMESTAMP WITHOUT TIME ZONE   ENCODE lzo
)
DISTSTYLE ALL
INTERLEAVED SORTKEY (
	"tracking_pixel_id"
	, "sales_invoice_id"
	)
;
ALTER TABLE edh.address_fact ADD FOREIGN KEY (update_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.address_fact ADD FOREIGN KEY (create_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.address_fact ADD FOREIGN KEY (country_id) REFERENCES edh.country_master(country_id);
ALTER TABLE edh.clerk_group_dim ADD FOREIGN KEY (clerk_key) REFERENCES edh.clerk_dim(clerk_key);
ALTER TABLE edh.country_master ADD FOREIGN KEY (country_currency_cd) REFERENCES edh.currency_master(currency_cd);
ALTER TABLE edh.customer_address_fact ADD FOREIGN KEY (update_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_address_fact ADD FOREIGN KEY (create_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_address_fact ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.customer_address_fact ADD FOREIGN KEY (address_id) REFERENCES edh.address_fact(address_id);
ALTER TABLE edh.customer_bio_fact ADD FOREIGN KEY (update_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_bio_fact ADD FOREIGN KEY (create_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_bio_fact ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.customer_comment_fact ADD FOREIGN KEY (update_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_comment_fact ADD FOREIGN KEY (create_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_comment_fact ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.customer_dim ADD FOREIGN KEY (update_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_dim ADD FOREIGN KEY (create_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_email_dim ADD FOREIGN KEY (update_src_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_email_dim ADD FOREIGN KEY (create_src_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_email_dim ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.customer_name_fact ADD FOREIGN KEY (update_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_name_fact ADD FOREIGN KEY (create_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_name_fact ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.customer_phone_fact ADD FOREIGN KEY (update_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_phone_fact ADD FOREIGN KEY (create_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_phone_fact ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.customer_preferred_interest_fact ADD FOREIGN KEY (update_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_preferred_interest_fact ADD FOREIGN KEY (create_source_system_key) REFERENCES edh.source_system_dim(source_system_key);
ALTER TABLE edh.customer_preferred_interest_fact ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.experian_aus_customer_dim ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.experian_uk_customer_dim ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.millward_brown_customer_dim ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.orders_fact ADD FOREIGN KEY (product_dim_key) REFERENCES edh.product_dim(product_key);
ALTER TABLE edh.orders_fact ADD FOREIGN KEY (date_key) REFERENCES edh.date_dim(date_key);
ALTER TABLE edh.sales_history_fact ADD FOREIGN KEY (transaction_key) REFERENCES edh.transaction_dim(transaction_key);
ALTER TABLE edh.sales_history_fact ADD FOREIGN KEY (time_key) REFERENCES edh.time_dim(time_key);
ALTER TABLE edh.sales_history_fact ADD FOREIGN KEY (product_key) REFERENCES edh.product_dim(product_key);
ALTER TABLE edh.sales_history_fact ADD FOREIGN KEY (order_date_key) REFERENCES edh.date_dim(date_key);
ALTER TABLE edh.sales_history_fact ADD FOREIGN KEY (invoice_date_key) REFERENCES edh.date_dim(date_key);
ALTER TABLE edh.sales_history_fact ADD FOREIGN KEY (gl_date_key) REFERENCES edh.date_dim(date_key);
ALTER TABLE edh.sales_history_fact ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.sales_history_fact ADD FOREIGN KEY (clerk_group_key) REFERENCES edh.clerk_group_dim(clerk_group_key);
ALTER TABLE edh.sales_history_fact ADD FOREIGN KEY (channel_key) REFERENCES edh.channel_dim(channel_key);
ALTER TABLE edh.sales_history_fact ADD FOREIGN KEY (tourism_key) REFERENCES edh.tourism_dim(tourism_key);
ALTER TABLE edh.subscription_dim ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);
ALTER TABLE edh.wealth_engine_customer_dim ADD FOREIGN KEY (customer_key) REFERENCES edh.customer_dim(customer_key);