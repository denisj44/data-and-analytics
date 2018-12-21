DROP TABLE if exists stage.raw_codeship_users;

CREATE TABLE stage.raw_codeship_users (
	user_id varchar(1000) NULL,
	user_name varchar(1000) NULL,
	email varchar(1000) NULL,
	github_username varchar(1000) NULL,
	user_created_at varchar(1000) NULL,
	user_token varchar(1000) null
	    , user_deleted_at varchar(1000) NULL
    , account_id varchar(1000) NULL
    , account_type varchar(1000) NULL
    , account_name varchar(1000) NULL
    , plan_key varchar(1000) null
    , external_account_id varchar(1000) null
    , account_team_membership_deleted_at varchar(1000) NULL
    , account_team_deleted_at varchar(1000) NULL
    , account_deleted_at varchar(1000) null
    , account_cancelled_at varchar(1000) null
    ,is_blacklist_account varchar(1000) null
    ,is_currency_miner_account varchar(1000) null
);
