#!/bin/bash

ip=$(hostname -I | awk '{print $1}')
IFS='.' read -r -a octets <<< "$ip"
number=0

for octet in "${octets[@]}"; do
    number=$(( (number << 8) + octet ))
done

echo $number
