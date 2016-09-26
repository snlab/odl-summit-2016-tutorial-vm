#!/bin/bash
ping $1 -c 1 & > /dev/null
iperf -c $1 -p 5550 -i 1
