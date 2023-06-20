#!/bin/bash
set -euf -o pipefail

apt install -y sysbench

sysbench --test=cpu --cpu-max-prime=20000 run > /root/bench-output/sysbench.txt

