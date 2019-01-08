#!/bin/bash

ip -6 addr | awk '/^[0-9]+/ { currentinterface=$2 } $1 == "inet6" { split( $2, foo, "/" ); print currentinterface ,foo[1] }'
