
truncate table 	public.users;

insert
	into
		public.users (
			full_name
			, email
			, is_internal_user
			,grandcentral_user_id
			, grandcentral_user_token
			, is_grandcentral
		)
		select distinct
			concat(firstname || ' ', lastname) as full_name
			, email
			,
			case
				when email like '%@cloudbees.%'
				or email like '%@codeship.%'
				or email like '%@railsonfire.%' then true
				else false
			end as is_internal_user
			 , user_id::bigint as grandcentral_user_id
			-- , null::bigint as codeship_user_id
			 , token as grandcentral_user_token
			-- , created_at::timestamp as		grandcentral_user_created_at,
			-- null::timestamp as		codeship_user_created_at,
			-- user_end_date::timestamp as		grandcentral_user_deleted_at,
			-- null::timestamp as 		codeship_user_deleted_at,
			-- false as		is_current_codeship,
			, true	as is_grandcentral
			-- false as		is_blacklist_org_member,
			-- false as		is_currency_miner_org_member
			from stage.raw_grandcentral_users
		-- order by email, created_at::timestamp
	
	;
	
		
--		select count(1)	from users
		
	
	insert
	into
		public.users (
			full_name
			, email
			, is_internal_user
			, codeship_user_id
			, is_codeship
			, is_codeship_blacklist_org_member
			, is_codeship_currency_miner_org_member
		)		

(
select distinct on (email)
	user_name as full_name
	, email
	,case
		when email like '%@cloudbees.%'
		or email like '%@codeship.%'
		or email like '%@railsonfire.%' then true
		else false
	end as is_internal_user
		, user_id::bigint as codeship_user_id
	, true as is_current_codeship
	,
	case
		when is_blacklist_account = '1' then true
		else false
	end as is_codeship_blacklist_org_member
	,
	case
		when is_currency_miner_account = '1' then true
		else false
	end as is_codeship_currency_miner_org_member
from
	stage.raw_codeship_users
	where email is not null
order by email, user_created_at desc -- ordering with distinct on to get most recent row if there are duplicate emails
)	
	
on conflict (email) do update set codeship_user_id=excluded.codeship_user_id
,is_codeship=excluded.is_codeship
,is_codeship_blacklist_org_member=excluded.is_codeship_blacklist_org_member
,is_codeship_currency_miner_org_member=excluded.is_codeship_currency_miner_org_member;




