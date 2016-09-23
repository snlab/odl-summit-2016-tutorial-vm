#!/bin/bash
python ARP_Handler.py & > /dev/null
iperf -s -p 5550 -i 1
