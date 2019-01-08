
-- Drop table
 drop
	table
		if exists user_login_summary;

create
	table
		user_login_summary (
			dw_user_login_summary_id bigserial not null primary key
			, dw_user_id bigserial not null
			, login_type character varying (100) not null -- e.g. codeship or grandcentral
			, login_created_at timestamp not null
			, login_deleted_at timestamp null
			, dw_created_at timestamp not null
			, dw_updated_at timestamp not null
			, dw_created_by character varying not null
			, dw_updated_by character varying not null
			, constraint uk_user_login_summary_dw_user_id_login_type_login_created_at unique (dw_user_id, login_type, login_created_at)
		);
