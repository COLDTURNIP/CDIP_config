#! /bin/bash

exip=`curl -s http://checkip.dyndns.org/ | grep -o "[[:digit:].]\+"`
echo "$exip"
