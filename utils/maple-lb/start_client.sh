#!/bin/bash
ping $1 -c 1 > /dev/null 
arp -s $1 00:00:00:00:00:06
iperf -c $1 -p 5550 -u -i 1
