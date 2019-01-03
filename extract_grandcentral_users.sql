\copy (    select u.id as user_id
    , u.firstname
    , u.middlename
    , u.lastname
    , u.email
    , u.username
    , u.created_at as user_created_at
    , u.token as user_token
    , u.end_date as user_end_date
    , au.deleted_at
    , a.id as account_id
    , a."domain"
    , a.token as account_token
    , a.salesforce_key
    , a.totango_key
    , a.end_date as account_end_date
    from users as u
    join account_users au on u.id = au.user_id
    join accounts a on  au.account_id = a.id 
) to 'output/grandcentral_users.csv' With (FORMAT CSV, HEADER)



