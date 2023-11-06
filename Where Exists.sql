-- This method for filtering is safe for nulls

Select
	Short_ID
	, Created_at
From Core.Shipments S
Where Exists -- This evalauates the correlated data from the second query and...
	(        -- ...only returns results that are True
	Select NULL
	From Core.Shipment_Exceptions SE
	Where S.Short_ID = SE.Short_ID
	)
Limit 100