with base as ( --Limits dataset and clean any potential null values for experiment

select
    route_distance_miles
    , cancelled_shipments
    , rescheduled_shipments
    , created_to_pickup
    , otp
    , otd
    , market_ttt
    , final_ttt_wo_incidentals
    , contribution_profit
from bi.wbr_shipments
where true
    and created_at >= '2023-01-01'
    and final_ttt_wo_incidentals is not null
    and otp is not null
)


, clean_data as (

select
        (select avg(route_distance_miles) from base) as distance_mean --calculates the mean of route_distance_miles
        , route_distance_miles - distance_mean as distance_residual -- calculated the variation of distance from avg distance (residual)
        , square(distance_residual) as distance_residual_squared -- squares the residual (in prep for summation of squares)
        , base.*
from base
)

select
    regr_r2(route_distance_miles, final_ttt_wo_incidentals) as r_squared
from clean_data