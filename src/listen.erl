-module(listen).
-include_lib("amqp_client/include/amqp_client.hrl").
-export([start/0]).

start() ->
    {Channel, Queue} = init_channel_queue(),
    io:format(" [*] Waiting for messages. To exit press CTRL+C~n"),    
    amqp_channel:subscribe(Channel, #'basic.consume'{queue = Queue, 
                                                     no_ack = true}, self()),
    receive
        #'basic.consume_ok'{} -> ok
    end,
    loop(Channel).

loop(Channel) ->
    receive
        {#'basic.deliver'{routing_key = RoutingKey}, #amqp_msg{payload = Body}} ->
            io:format(" [x] ~p:~w ", [RoutingKey, Body]),
            fizzbazz:eval(Body),
            loop(Channel)
    end.

init_channel_queue() ->
    Host = "localhost",
    Exchange = <<"all">>,
    RoutingKey = <<"X.USER.*">>,
    {ok, Connection} =
        amqp_connection:start(#amqp_params_network{host = Host}),
    {ok, Channel} = amqp_connection:open_channel(Connection),
    amqp_channel:call(Channel, #'exchange.declare'{exchange = Exchange, 
                                                   type = <<"topic">>}),
    #'queue.declare_ok'{queue = Queue} =
        amqp_channel:call(Channel, #'queue.declare'{exclusive = true}),
    amqp_channel:call(Channel, #'queue.bind'{exchange = Exchange,
                                              routing_key = RoutingKey,
                                              queue = Queue}),
    {Channel, Queue}.