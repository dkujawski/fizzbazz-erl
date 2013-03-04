fizzbazz-erl
============

learning erlang with fizzbazz

I always forget to wget these:

wget http://www.rabbitmq.com/releases/rabbitmq-erlang-client/v2.7.0/rabbit_common-2.7.0.ez
unzip rabbit_common-2.7.0.ez
ln -s rabbit_common-2.7.0 rabbit_common

wget http://www.rabbitmq.com/releases/rabbitmq-erlang-client/v2.7.0/amqp_client-2.7.0.ez
unzip amqp_client-2.7.0.ez
ln -s amqp_client-2.7.0 amqp_client

the symlinks need to be in the include dir
