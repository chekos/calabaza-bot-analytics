
/*
    Cleaning up /morning data to visualize it
*/

{{ config(materialized='view') }}

-- select * from {{ ref('stg_morning_view') }}

{{ dbt_utils.unpivot(
  relation=ref('stg_morning_view'),
  exclude=['user_id', 'created_at_pst', 'dreamed', 'sleep_hrs'],
  field_name='feel',
  value_name='value'
) }}
