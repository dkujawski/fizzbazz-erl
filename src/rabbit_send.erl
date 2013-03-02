-module(send).
-include_lib("amqp_client/include/amqp_client.hrl").
-export([loop/0]).

loop() ->
    RNum = random:uniform(100),
    {Route, Message} = {<<"X.USER.dkujawski">>, <<RNum>>},
    {Connection, Channel, Exchange} = init_conn_channel(),
    send_message({Channel, Exchange, Route, Message}),
    close_conn_channel({Connection, Channel}),
    io:format(" [x] Sent ~p: ~w~n", [Route, Message]),
    timer:sleep(5000),
    loop().

init_conn_channel() ->
    Host = "localhost",
    Exchange = <<"all">>,
    {ok, Connection} = 
        amqp_connection:start(#amqp_params_network{host = Host}),
    {ok, Channel} = amqp_connection:open_channel(Connection),
    amqp_channel:call(Channel, #'exchange.declare'{exchange = Exchange, 
                                                   type = <<"topic">>}),
    {Connection, Channel, Exchange}.

send_message({Channel, Exchange, Route, Message}) ->
    amqp_channel:cast(Channel, 
                      #'basic.publish'{exchange = Exchange, 
                                       routing_key = Route},
                      #amqp_msg{payload = Message}).

close_conn_channel({Connection, Channel}) ->
    ok = amqp_channel:close(Channel),
    ok = amqp_connection:close(Connection).
