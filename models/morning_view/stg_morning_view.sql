-- Stage the morning_check_ins data to be unpivoted later
with last_entry_of_the_day as (
    select max(created_at_utc)
    from {{ source('calabaza_mc', 'morning_check_in') }}
    group by day(created_at_utc)
),

morning_checkins as (
    select
        user_id,
        sleep_hrs,
        dreamed,
        feel_right_now,
        feel_about_today,
        dateadd(hours, -8, created_at_utc) as created_at_pst
    from {{ source('calabaza_mc', 'morning_check_in') }}
    where created_at_utc in (select * from last_entry_of_the_day)
)

select * from morning_checkins