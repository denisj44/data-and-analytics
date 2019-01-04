
-- Drop table
 drop
	table
		if exists user_login_creation;

create
	table
		user_login_creation (
			dw_user_event_id bigserial not null primary key
			, dw_user_id bigserial not null
			, login_type character varying (100) not null -- e.g. codeship or grandcentral
			, login_created timestamp not null
			, login_deleted timestamp null
			, constraint uk_user_login_creation unique (dw_user_id, login_type, login_created)
		);
