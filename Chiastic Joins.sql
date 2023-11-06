Select
	Sh.Short_ID
	, SE.Category_Code
	, SE.Resolved_By_ID
	, OE.Manager_Name
From Core.Shipments as Sh
	Left Outer Join Core.Shipment_Exceptions as SE
		Inner Join Bi.Ops_Employees as OE -- This join is executed after...
		On OE.User_ID = SE.Resolved_By_ID -- ...this evaluation is completed. Matching users to exceptions.
	On Sh.ID = SE.Shipment_ID			  -- This join is the evaulated as an outer join to display the results
Where true
Limit 1000