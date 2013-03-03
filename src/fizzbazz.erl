-module(fizzbazz).
-export([start/1, eval/1]).

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
	{ok, Response} = eval(Number),
	io:format("~w ~p~n", [Response, Number]),
	run(Others);
run([]) -> ok.

eval(Number) when Number rem 3 == 0 ->
	case Number rem 5 == 0 of
		true -> 
			{ok, fizzbazz};
		false ->
			{ok, fizz}
	end;
eval(Number) when Number rem 5 == 0 ->
	{ok, bazz};
eval(<<Number:8,_Rest/binary>>) ->
	eval(Number);
eval(Number) ->
	{ok, Number}.

