%%%-------------------------------------------------------------------
%% @doc callcenter public API
%% @end
%%%-------------------------------------------------------------------

-module(callcenter_app).

-behaviour(application).

-export([start/2, stop/1, showoptionlist/0]).

start(_StartType, _StartArgs) -> callcenter_sup:start_link().

stop(_State) -> ok.

showoptionlist() -> 
    List1 = ["Press 1 to give me an Hug","Press 2 to give me a pizza", "Press 3 to give me some Sushi"],
    print_the_list(List1),
    ok.

print_the_list([]) -> [];
print_the_list([H|T]) ->
    io:format("~p~n", [H]),
    [H|print_the_list(T)].
