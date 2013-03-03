-module(listen).
-export([start/0, listener/0]).

start() ->
    io:format(" [*] Waiting for messages. To exit press CTRL+C~n"),    
    register(listener, spawn(listen, listener, [])).

listener() ->
    receive
        finished ->
            io:format("listener finished ~n", []);
        {sender, Message} ->
            io:format(" [o] received : ~w ", [Message]),
            {ok, Response} = fizzbazz:eval(Message),
            io:format("~w ~p~n", [Response, Message]),
            listener()
    end.

