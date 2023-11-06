select
    first_name
    , SoundEx(First_Name) Soundex_Value
    , lag(first_name, -1) over(order by hire_date) as Lag_First_Name
    , SoundEx(Lag_First_Name) Soundex_Value
    , EditDistance(First_Name, Lag_First_Name) as String_Diff
from bi.ops_employees
where true
and active_status = true 