\copy (  
with cte_blacklist_acct as (
		select
			distinct account_id
		from
			blacklists ),			
cte_currency_miner as (
		select
			distinct accounts.id as account_id
		from
			accounts as accounts
		join user_trials as user_trials on
			user_trials.account_id = accounts.id
		where
			user_trials.created_at - accounts.created_at < interval '2' hour
			)
select
	 u.id as user_id
    , u."name" as user_name
    , u.email
    , u.github_username
    , u.created_at as user_created_at
    , u.user_token
    , u.deleted_at
    , a.id as account_id
    , a."type" as account_type
    , a."name" as account_name
    , a.plan_key 
    , a.external_account_id
    , atm.deleted_at as account_team_membership_deleted_at
    , act.deleted_at as account_team_deleted_at
    , a.deleted_at as account_deleted_at
    , a.canceled_at as account_cancelled_at
    , case 
    	when bl.account_id is not null then 1 else 0 
    	end as is_blacklist_account
    	,case when cm.account_id is not null then 1 else 0
    	end as is_currency_miner_account
from
	users as u
	left join account_team_memberships as atm on u.id=atm.user_id
	left join account_teams as act on atm.team_id=act.id
	left join accounts as a on act.account_id=a.id
left join cte_blacklist_acct as bl on
	a.id = bl.account_id
left join cte_currency_miner as cm on
	a.id = cm.account_id
	) to 'output/codeship_users.csv' With (FORMAT CSV, HEADER)
