-module(callcenter_app).

%TODO: not necessary
-import(connection_app, [encode_msg/2, decode_msg/2]).
-behaviour(application).

-export([start/2, stop/1, show_option_list/0, request_random_joke/0, start_connection_with_call_center/0, show_caller_id/0]).

start(_StartType, _StartArgs) -> callcenter_sup:start_link().

stop(_State) -> ok.

%1) Show Some Option 
show_option_list() -> 
    List1 = ["Press 1 to give me an Hug","Press 2 to give me a pizza", "Press 3 to give me some Sushi"],
    print_the_list(List1),
    ok.

print_the_list([]) -> [];
print_the_list([H|T]) ->
    io:format("~s \n", [H]),
    [H|print_the_list(T)].

%2) Request a random Joke 
request_random_joke() ->
    Num = rand:uniform(4),
    io:format("~s \n", [lists:nth(Num, populate_list_joke())]).

populate_list_joke() ->
    List1 = ["I'll Delete your OS Now! :D ","Valve present Half-life 3!!!", "Who read this algorithm probably make seppuku at the end... XD", "Ducks say 'Quak' but there isn't sign of quak...e! D:"],
    List1.

%3) Show Unique Id callcenter
%Work Without it ---> rd(connectionprocess, {id = [], username = ""}).
%callcenter_app:start_connection_with_call_center().
%callcenter_app:show_caller_id().

-record(connectionprocess, {username = "", id = []}).
start_connection_with_call_center() ->
    UniqueId = erlang:phash2({node(), now()}), 
    Currentuser = "User_" ++ erlang:integer_to_list(UniqueId),
    Connectionid = #connectionprocess{id=UniqueId, username=Currentuser},
    Connectionid#connectionprocess.id .

show_caller_id() -> get_value('id', connectionprocess).

get_value(F, R)  -> 
    Ciccio = element(field_index(F), R),
    io:format("HERE"),
    Ciccio.

field_index(F) ->
    Fields = record_info(fields, connectionprocess),
    index(F, Fields, 2).

index(M, [M|_], I) -> I;
index(M, [_|T], I) -> index(M, T, I+1). 
