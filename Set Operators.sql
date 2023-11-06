with shipments as (

select
    Short_ID
from core.shipments
where true
    and shipper_friendly_prefix = 'SYS'
    and created_at >= current_timestamp() - interval '4 week' 
)

, exceptions as (

select
    short_id
from core.shipment_exceptions
where true
    and shipper_friendly_prefix = 'SYS'
    and created_at >= current_timestamp() - interval '4 week' 

)

, union_data as (

select *
from shipments

-- Union all --Displays both sets of data from both tables without grouping (120 Rows)
-- Union -- Display data from both tables but groups duplicates (36 Rows)
Intersect -- Displays data from both sets only where rows overlap (15 Rows)
-- Except --Display rows from both tables only where rows do not overlap (6 Rows)

select *
from exceptions

)

select *
from union_data
order by short_id desc