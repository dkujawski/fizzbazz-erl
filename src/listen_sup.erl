-module(listen_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link(listen_sup, []).

init(_Args) ->
    {ok, {{one_for_one, 1, 60},
          [{listen, {listen, start, []},
            permanent, brutal_kill, worker, [listen]}]}}.

