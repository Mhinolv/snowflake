with base as (

select
    route_distance_miles
    , final_ttt_wo_incidentals
from bi.wbr_shipments
where true
    and created_at >= '2023-01-01'
    and final_ttt_wo_incidentals is not null
    and otp is not null
)


, sst as (

select
        (select avg(route_distance_miles) from base) as distance_mean
        , route_distance_miles - distance_mean as distance_residual
        , square(distance_residual) as distance_residual_squared
from base
)

select 
    sum(distance_residual_squared) as SST
    , sst / count(*) as SST_mean
from sst