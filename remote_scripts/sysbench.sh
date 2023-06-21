#!/bin/bash
set -euf -o pipefail

apt install -y sysbench

# CPU Test
echo "Running CPU test..."
sysbench cpu --cpu-max-prime=20000 run > /root/bench-output/sysbench-cpu.txt

# Memory Test
echo "Running Memory test..."
sysbench memory --memory-total-size=1G run > /root/bench-output/sysbench-memory.txt

