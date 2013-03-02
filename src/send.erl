-module(send).
-export([start/0, start/1, sender/0, sender/1]).

start() ->
    spawn(send, sender, []).

start([ListenerNode]) ->
    io:format("~p~n", [ListenerNode]),
    spawn(send, sender, [ListenerNode]).

sender() ->
    RNum = random:uniform(100),

    listener ! {sender, RNum},

    io:format(" [x] Sent : ~w~n", [RNum]),
    timer:sleep(5000),
    sender().

sender(ListenerNode) ->
    RNum = random:uniform(100),

    {listener, list_to_atom(ListenerNode)} ! {sender, RNum},

    io:format(" [x] Sent : ~w~n", [RNum]),
    timer:sleep(5000),
    sender(ListenerNode).