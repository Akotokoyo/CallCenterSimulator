%%%-------------------------------------------------------------------
%% @doc CallCenter public API
%% @end
%%%-------------------------------------------------------------------

-module(CallCenter_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    CallCenter_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
