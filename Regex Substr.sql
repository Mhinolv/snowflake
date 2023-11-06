select
    regexp_substr(body, 'h...s') protocol --The '.' (period) is a wildcard to search for any character 'h...s' returns https
    , regexp_substr(body, 'ht*.s') protocol_2 --The '*' (asterisk) matches as many characters as the character before it. Can return zero values
    , regexp_substr(body, '3.,0*') as weight
    , regexp_substr(body, 'ht+.s') protocol_3 --The '+' (plus) is similar to the '*' but will not return zero values of the character
    , regexp_substr(lower(body), '[hH]..[mM]..') as condition --Square brackets '[]' look for a charcter set with them. '[hH]' will search for either the 'h' or 'H' character
    , regexp_substr(upper(body), '[hH]..[mM]..') as condition_2 -- Notice the code remains the same but still returns the value when the UPPPER function is called
    , regexp_substr(body, '[^AEIOUaeiou]') as first_consenant --The '^' (caret) used within square brackets, excludes the specificed character from getting returned
    , body
from core.emails
where true
    and message_id = 'f0efd038-51b4-47e0-8ab6-ae23cd15099e'
limit 1