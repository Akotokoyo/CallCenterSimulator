-module(callcenter_app).

-import(connection_app, [encode_msg/2, decode_msg/2]).
-behaviour(application).

-export([start/2, stop/1, show_option_list/0, request_random_joke/0, show_caller_id/0]).

start(_StartType, _StartArgs) -> 
    show_option_list(),
    callcenter_sup:start_link().

stop(_State) -> ok.

%1) Show Some Option 
show_option_list() -> 
    List1 = ["1 - Use show_option_list command to show Option List","2 - Use request_random_joke command to obtain a random joke", "3 - user show_caller_id to show your current id"],
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
show_caller_id() -> 
    Port = erlang:open_port({spawn, "wc /dev/zero"}, []),
    Portinfo = erlang:port_info(Port),
    Portinfo .
