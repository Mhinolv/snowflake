-- This query sums the total count of rows as well as the distrbution %

Select
    Program_Type
    , Count(*) * 100 / Sum(Count(*)) Over() Program_Perc
From Core.Shipments
[[Where Created_At Between {{Start}} and {{End}}]]
Group by 
    Program_Type
Order by Program_Perc desc