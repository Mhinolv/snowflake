with actions as (

select
	id
	, shipment_id
	, case 
		when meta.key = 'acceptedFields' then 'DONE'
		when meta.key = 'rejectedFields' then 'IGNORE'
		when meta.key = 'appliedFields' then 'APPLY'
		end as action_taken
	, fields.value::varchar as fields
	, resolved_at
	, resolved_by
from src.shipment_update_request
, lateral flatten (input => metadata) meta
, lateral flatten (input => meta.value, recursive => true) fields
where true
--	and id = '782f6009-f90c-4781-9268-39118cd1a6bc'

)

, stop_diff as (

select distinct
	id
	, shipment_id
	, 'stop' || '.' || diff2.index || '.' as stop
	, diff3.this
from src.shipment_update_request
, lateral flatten (input => diff) diff
, lateral flatten (input => diff.value) diff2
, lateral flatten (input => diff2.value) diff3
where true
--	and id = '782f6009-f90c-4781-9268-39118cd1a6bc'
)

, stop_changes as (

select
	id
	, shipment_id
	, stop || diff2.key as stop_changes
	, diff2.value as changes
	, diff2.value:currentValue::varchar as current_value
	, diff2.value:newValue::varchar as new_value
	, diff2.value:outdated::boolean as outdated
from stop_diff
, lateral flatten (input => this) diff
, lateral flatten (input => diff.value) diff2

)

, stop_actions as (

select
	a.id
	, a.shipment_id
	, a.action_taken
	, a.fields
	, sc.current_value
	, sc.new_value
	, sc.outdated
	, a.resolved_at
	, a.resolved_by
	, sc.changes as stop_metadata
from actions a 
left join stop_changes sc
	on a.id = sc.id
	and a.fields = sc.stop_changes
)

select *
from stop_actions
order by
	id
	, shipment_id
limit 100