
/*
    Cleaning up /logs into a nicer view to choose for /getlogs
*/

{{ config(materialized='view') }}

with text_logs as (
    select * 
    from {{ source('calabaza', 'notes') }} 
    where text is not null
)

select * from text_logs