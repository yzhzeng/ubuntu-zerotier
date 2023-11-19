#!/bin/bash


if [[ -z "$NETWORK_ID" ]]; then
  echo "Please set 'NETWORK_ID'"
  exit 2
fi

if [[ -z "$USER_PASS" ]]; then
  echo "Please set 'USER_PASS' for user: $USER"
  exit 3
fi

echo "### Install zerotier and join network ###"

curl -s https://install.zerotier.com | sudo bash
sudo zerotier-cli start
sudo zerotier-cli join "$NETWORK_ID"

echo "### Update user: $USER password ###"
echo -e "$USER_PASS\n$USER_PASS" | sudo passwd "$USER"
#sleep 20
#sudo ifconfig ztwfuijnog 192.168.196.205 netmask 255.255.255.0
sudo apt update
sudo apt install squid
sudo cp ./squid.conf /etc/squid/
sudo systemctl restart squid

sleep 10
#HAS_ERRORS=$(grep "command failed" < .ngrok.log)

#if [[ -z "$HAS_ERRORS" ]]; then
#  echo ""
#  echo "=========================================="
#  echo "To connect: $(grep -o -E "tcp://(.+)" < .ngrok.log | sed "s/tcp:\/\//ssh $USER@/" | sed "s/:/ -p /")"
#  echo "=========================================="
#else
#  echo "$HAS_ERRORS"
#  exit 4
#fi
