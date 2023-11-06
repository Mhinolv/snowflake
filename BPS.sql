with corr_data as (
  select
    corr(route_distance_miles, contribution_profit) as mile_cp_corr,
    date_trunc('week', created_at)::date as week
  from
    bi.wbr_shipments
  where
    week >= current_timestamp() - interval '3 months'
  group by
    week
)
select
  week,
  mile_cp_corr,
  coalesce(round((mile_cp_corr - lag(mile_cp_corr) OVER (ORDER BY week)) * 10000, 0), 0) as bps_change
from
  corr_data
order by
    week desc