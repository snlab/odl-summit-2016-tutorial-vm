#!/bin/bash
ping $1 -c 1
iperf -c $1 -p 5550 -i 1
