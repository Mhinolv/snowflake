Select
    Upper(first_name) as First_Name
    , Upper(randstr(4, random(4)) || '-' ||randstr(4, random(1)) || '-' ||randstr(4, random(5)) || '-' ||randstr(4, random(17))) as UID
    , count(first_name) Record_Count
    , avg(uniform(1, 100, random(3))) as Arb_Rate
    , convert_timezone('US/Pacific',sysdate()) as Sys_Timestamp
    , Upper(UUID_STRING()) as Sess_ID
From bi.ops_employees
Where true
    [[and {{first_name}}]]
Group by
    First_Name
Order by first_name