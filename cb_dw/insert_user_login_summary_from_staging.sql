truncate table 	public.user_login_summary;

insert
	into
		public.user_login_summary ( --rename to user_login_summary
			dw_user_id
			, login_type
			, login_created_at
			, login_deleted_at
			, dw_created_at
			, dw_updated_at
			, dw_created_by
			, dw_updated_by
		) select 
			u.dw_user_id
			, 'GrandCentral' as login_type
			, rgu.created_at::timestamp as login_created_at
			-- to determine when a user has been "deleted" check the following (the earliest value is the "deleted" date):
			-- users.end_date is populated
			-- whether there is no account id associated with the user (i.e. no org)
			-- if the account_users.deleted_at is populated
			-- if the accounts.end_date is populated
			-- Also, when a user is associated with more than one org, all orgs must be checked to confirm the user has been completely deleted.
			-- need to add check for api_account_creation.deleted_at
			, case
				when max(
					least(
						coalesce(rgu.user_end_date,'30000-12-31') ::timestamp
						,case
							when rgu.account_id is null then rgu.created_at::timestamp -- if null then assume deleted and use the creation date as the deleted date since the actual is unknown
							else '30000-12-31'::timestamp
						end
					,coalesce(rgu.account_user_deleted_at, '30000-12-31')::timestamp
					,coalesce(rgu.account_end_date, '30000-12-31')::timestamp
						)
					) 
					= '30000-12-31' then null::timestamp
					else
					max(
					least(
						coalesce(rgu.user_end_date,'30000-12-31') ::timestamp
						,case
							when rgu.account_id is null then '0001-01-01'::timestamp -- if null then assume deleted and choose a date that indicates the deleted date is unknown
							else '30000-12-31'::timestamp
						end
					,coalesce(rgu.account_user_deleted_at, '30000-12-31')::timestamp
					,coalesce(rgu.account_end_date, '30000-12-31')::timestamp
						)
					) 
				end	as login_deleted_at 
			, current_timestamp as dw_created_at
			, current_timestamp as dw_updated_at
			, 'user_login_creation dump/reload - user: '||current_user as dw_created_by
			, 'user_login_creation dump/reload - user: '||current_user as dw_updated_by
		from
			stage.raw_grandcentral_users as rgu
		join public.users as u on
			rgu.email = u.email	
		group by u.dw_user_id, login_type, login_created_at, dw_created_at, dw_updated_at, dw_created_by, dw_updated_by;
	
	
	
	insert
	into
		public.user_login_summary ( --rename to user_login_summary
			dw_user_id
			, login_type
			, login_created_at
			, login_deleted_at
			, dw_created_at
			, dw_updated_at
			, dw_created_by
			, dw_updated_by
		) select distinct
			u.dw_user_id
			, 'CodeShip' as login_type
			, rcu.user_created_at::timestamp as login_created_at
			, rcu.user_deleted_at::timestamp as login_deleted_at
			, current_timestamp as dw_created_at
			, current_timestamp as dw_updated_at
			, 'user_login_creation dump/reload - user: '||current_user as dw_created_by
			, 'user_login_creation dump/reload - user: '||current_user as dw_updated_by
		from
			stage.raw_codeship_users as rcu
		join public.users as u on
			rcu.email = u.email	;
	

		
		