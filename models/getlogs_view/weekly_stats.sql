
/*
    Cleaning up /logs into a nicer view to choose for /getlogs
*/

{{ config(materialized='view') }}

with text_logs as (
    select user_id, type, count(*) as count 
    from {{ source('calabaza', 'notes') }} 
    group by user_id, type
    order by count desc
)

select * from text_logs