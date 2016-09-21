#!/bin/bash
ping 10.0.0.7 -c 1 > /dev/null
arp -s 10.0.0.1 00:00:00:00:00:01
arp -s 10.0.0.2 00:00:00:00:00:02
iperf -s -p 5550 -u -i 1
