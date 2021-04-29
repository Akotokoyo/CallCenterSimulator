-module(client).

-export([run/0]).

-record(service, {name, handler}).

%TODO: METTERE NOMI CONSONI
services() ->
    [#service{name = "Show Random Joke", handler=fun show_random_joke/0},
     #service{name = "My caller ID", handler=fun handle_caller_id/0}].

run() ->
	Flusher = spawn(fun flush/0),
    sockclient:connect(Flusher),
    sockclient:send_create_session(),
    loop(services()).

loop(Services) ->
	timer:sleep(100),
    case automatic_responder(Services) of
        quit -> ok;
        _ -> loop(Services)
    end.

automatic_responder(Services) ->
    io:format("Automatic Responder:\n"),
    io:format(build_help_message(Services)),
    X = help_ask(length(Services)),
    S = lists:nth(X, Services),
    (S#service.handler)().

build_help_message(Services) -> build_help_message("", 1, Services).
build_help_message(Msg, _, []) -> Msg;
build_help_message(Msg, N, [#service{name=Name}|Services]) ->
    NewMsg = io_lib:format("~s~b. ~p~n", [Msg, N, Name]),
    build_help_message(NewMsg, N+1, Services).

help_ask(NOptions) ->
    case io:fread("Choose an option> ", "~d") of
        {ok, [X]} when X >= 1 andalso X =< NOptions -> X;
        _ -> io:format("Invalid answer.~n"), help_ask(NOptions)
    end.

show_random_joke() ->
    sockclient:show_random_joke().

handle_caller_id() ->
    sockclient:send_get_unique_caller_id().

flush() ->
    receive
        Message ->
            io:format(Message),
			flush()
    end.
