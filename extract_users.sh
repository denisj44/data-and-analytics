#!/bin/bash
# extract data from grandcentral and codeship
psql -h ec2-34-232-18-207.compute-1.amazonaws.com -U u7l8hfc99f7vh6 -d d675vpbbpo7273 -f <(tr '\n' ' ' < extract_code_ship_users.sql) 
psql -h cbprodpg2.c9t4sg4nfizr.us-east-1.rds.amazonaws.com -U grandcentral_ro -d grandcentral_production -f <(tr '\n' ' ' < extract_grandcentral_users.sql)
# load data into corresponding staging tables
psql -h da-dw-dev.ci8ic0ywvga2.us-east-1.rds.amazonaws.com -U postgres -d cb_dw -c "\COPY stage.raw_grandcentral_users FROM '~/cloudbees/data-and-analytics/output/grandcentral_users.csv' WITH (FORMAT CSV, HEADER);"
psql -h da-dw-dev.ci8ic0ywvga2.us-east-1.rds.amazonaws.com -U postgres -d cb_dw -c "\COPY stage.raw_codeship_users FROM '~/cloudbees/data-and-analytics/output/codeship_users.csv' WITH (FORMAT CSV, HEADER);" 
