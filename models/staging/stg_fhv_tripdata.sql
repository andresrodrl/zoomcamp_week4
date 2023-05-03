{{ config(materialized='view') }}

with tripdata as 
(
  select *
  from {{ source('staging','fhv_tripdata') }}
)

select
    -- identifiers
    cast(dispatching_base_num as string) as base_numid,
    cast(PUlocationID as integer) as  pickup_locationid,
    cast(DOlocationID as integer) as dropoff_locationid,
    cast(SR_Flag as integer) as sr_flagid,
    cast(Affiliated_base_number as string) as affid,
    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropoff_datetime
    
from tripdata



-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=false) %}

  limit 100

{% endif %}