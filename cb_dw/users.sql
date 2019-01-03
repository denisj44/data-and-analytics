-- Drop table

 DROP TABLE if exists users;

CREATE TABLE users (
dw_user_id bigserial not null primary key,
full_name varchar(1000) null,
email	varchar(1000) not null,
is_internal_user boolean not null,
grandcentral_user_id int NULL,
codeship_user_id int null,
grandcentral_user_token varchar(1000) null,
-- grandcentral_user_created_at timestamp NULL,
-- codeship_user_created_at timestamp NULL,
-- grandcentral_user_deleted_at  timestamp NULL,
-- codeship_user_deleted_at  timestamp NULL,
		is_codeship boolean  null,
		is_grandcentral boolean  null,
		is_codeship_blacklist_org_member boolean  null,
		is_codeship_currency_miner_org_member boolean  null,
	CONSTRAINT uk_users_email unique (email),
		CONSTRAINT uk_users_grandcentral_user_id unique (grandcentral_user_id),
			CONSTRAINT uk_users_codeship_user_id unique (codeship_user_id)
);
	


	
		
