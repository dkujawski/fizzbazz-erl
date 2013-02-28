-module(prime).
-export([start/1, eval/1]).

start(Number) when is_integer(Number) ->
	eval(Number);
start([StrNum|Others]) ->
	case string:to_integer(StrNum) of
		{error, no_integer} ->
			io:format("~p: not a number~n", [StrNum]);
		{Number, _Rest} ->
			eval(Number)
	end,
	start(Others);
start([]) ->
	io:format("done~n").

eval(Number) when is_integer(Number) ->
	loop(2, Number).

loop(N, Number) when N =< Number-1 ->
	case Number rem N == 0 of
		true -> 
			false;
		false ->
			loop(N+1, Number)
	end;
loop(Number, Number) ->
	io:format("~w PRIME~n", [Number]).
