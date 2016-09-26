#!/bin/bash
ping 10.0.0.7 -c 1 > /dev/null &
python ARP_Handler.py > /dev/null &
iperf -s -p 5550 -i 1
