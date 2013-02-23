-module(fizzbazz).
-export([start/1]).

start(Number) when is_integer(Number) ->
	run(lists:seq(1, Number));
start([StrNum|Others]) ->
	case string:to_integer(StrNum) of
		{error, no_integer} ->
			io:format("~p: not a number~n", [StrNum]);
		{Number, _Rest} ->
			run(lists:seq(1, Number))
	end,
	start(Others);
start([]) ->
	io:format("done~n").

run([Number|Others]) ->
	eval(Number),
	run(Others);
run([]) -> ok.

eval(Number) when Number rem 3 == 0 ->
	case Number rem 5 == 0 of
		true -> 
			io:format("~w fizzbazz~n",[Number]);
		false ->
			io:format("~w fizz~n", [Number])
	end;
eval(Number) when Number rem 5 == 0 ->
	io:format("~w bazz~n", [Number]);
eval(Number) ->
	io:format("~w~n", [Number]).

