


DROP TABLE if exists stage.raw_grandcentral_users;

CREATE TABLE stage.raw_grandcentral_users (
	user_id varchar(1000) NULL,
	firstname varchar(1000) NULL,
	middlename varchar(1000) NULL,
	lastname varchar(1000) NULL,
	email varchar(1000) NULL,
	username varchar(1000) NULL,
	created_at varchar(1000) NULL,
	token varchar(1000) null
	    , user_end_date varchar(1000) NULL
    , account_user_deleted_at varchar(1000) NULL
    , account_id varchar(1000) NULL
    , account_domain varchar(1000) NULL
    , account_token varchar(1000) NULL
    , account_salesforce_key varchar(1000) NULL
    , account_totango_key varchar(1000) NULL
    , account_end_date varchar(1000) NULL
);

