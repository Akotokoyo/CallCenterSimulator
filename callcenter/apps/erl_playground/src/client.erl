-module(client).

-export([run/0, reset/0, operator_interaction/2, check_timeout/0]).

-record(service, {name, handler}).
-define('CUSTOM_INDEX', 3).
-define('CUSTOM_TIMEOUT', 10000).

services() ->
    [#service{name = "Show Random Joke", handler=fun show_random_joke/0},
     #service{name = "My caller ID", handler=fun handle_caller_id/0},
     #service{name = "Ask the operator", handler=fun ask_the_operator/0}].

run() ->
	Flusher = spawn(fun flush/0),
    sockclient:connect(Flusher),
    sockclient:send_create_session(),
    loop(services()).

reset() ->
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
        _ -> io:format("Input Not Valid, Retry. \n"), help_ask(NOptions)
    end.

ask_the_operator() ->
    io:format("Hi, I'm your personal Operator! Send ad input string or a number \n"),
    PID = spawn(?MODULE, check_timeout, []),
    operator_interaction(0, PID).

operator_interaction(CurrentIndex, PID) ->
    if CurrentIndex < ?CUSTOM_INDEX ->
        case ask_input("> ") of
            Msg ->
                sockclient:ask_an_operator(Msg),
                UpdatedIndex = CurrentIndex +1,
                operator_interaction(UpdatedIndex, PID)
        end
    ; true ->
        exit(PID, ok),
        reset()
    end.

check_timeout() ->
    receive {} -> ok
    after ?CUSTOM_TIMEOUT ->
        io:format("Time Out, you'll be back in Automatic Reponder Section \n", []),
        ok
    end,
    reset().

ask_input(Prompt) ->
    case io:get_line(Prompt) of
        eof ->
            io:format("Invalid input."),
            ask_input(Prompt);
        {error, Desc} ->
            io:format("Error: ~s", [Desc]),%
            ask_input(Prompt);
        Input ->
            case string:trim(Input) of
                "" -> ask_input(Prompt);
                S -> S
            end
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