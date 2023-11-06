/*
The syntax is as follows:

Field_name:object.children::cast_type

Ex:input_json:Destination.City::string as City

Field_name: input_json
Object: Destination
Children: City
Cast: String
*/

select
    input_json:Destination.City::string as City
    , input_json:Destination.State::string as State
    , input_json:Destination.Country::string as Country
    , input_json:Destination.kma::String as KMA
    , input_json:RateCriteria.Radius::String as Radius
    , input_json
From src.truckstop_weekly_rates
Where State in ('TX')
Limit 10