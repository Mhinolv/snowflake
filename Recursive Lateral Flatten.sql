Select distinct
    path
    , value
From src.activity_feed_items
    , lateral flatten (input => parse_json(data):stops, Recursive => True)
Limit 500