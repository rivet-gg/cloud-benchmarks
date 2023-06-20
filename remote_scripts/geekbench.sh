#!/bin/bash
set -euf -o pipefail

GEEKBENCH_VERSION=6.1.0-Linux
wget http://cdn.geekbench.com/Geekbench-${GEEKBENCH_VERSION}.tar.gz
tar -xf Geekbench-${GEEKBENCH_VERSION}.tar.gz
cd Geekbench-${GEEKBENCH_VERSION}
./geekbench6 > /root/bench-output/geekbench6.txt

