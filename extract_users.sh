psql -h ec2-34-232-18-207.compute-1.amazonaws.com -U u7l8hfc99f7vh6 -d d675vpbbpo7273 -f <(tr '\n' ' ' < extract_code_ship_users.sql) 
psql -h cbprodpg2.c9t4sg4nfizr.us-east-1.rds.amazonaws.com -U grandcentral_ro -d grandcentral_production -f <(tr '\n' ' ' < extract_grandcentral_users.sql)
