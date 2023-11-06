--Sub select that compares shipments.id to shipment.exceptions.shipment_id in the core.shipment_exceptions table starts with "KFT"

Select *
From bi.shipments
Where 
    id in (Select shipment_id From core.shipment_exceptions where short_id like ('KFT%')) 