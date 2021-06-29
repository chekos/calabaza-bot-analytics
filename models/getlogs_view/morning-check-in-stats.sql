
/*
    Cleaning up /morning data to visualize it
*/

{{ config(materialized='view') }}

with last_entry_of_the_day as (
    select max(created_at_utc)
    from {{ source('calabaza', 'morning_check_in') }}
    group by day(created_at_utc)
),

morning_checkins as (
    select
        user_id,
        sleep_hrs,
        dreamed,
        feel_right_now,
        feel_about_today,
        created_at_utc
    from {{ source('calabaza', 'morning_check_in') }}
    where created_at_utc in (select * from last_entry_of_the_day)
)

select * from morning_checkins;