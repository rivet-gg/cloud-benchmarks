#!/bin/bash
set -euf -o pipefail

mkdir -p /root/bench-output

apt update -y
apt install -y curl

