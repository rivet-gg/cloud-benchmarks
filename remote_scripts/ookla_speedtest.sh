#!/bin/bash
set -euf -o pipefail

curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
apt install -y speedtest
speedtest --accept-license > /root/bench-output/ookla_speedtest.txt

