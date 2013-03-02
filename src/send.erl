-module(send).
-export([start/0, sender/0]).

start() ->
    spawn(send, sender, []).

sender() ->
    RNum = random:uniform(100),

    listener ! {sender, RNum},

    io:format(" [x] Sent : ~w~n", [RNum]),
    timer:sleep(5000),
    sender().

