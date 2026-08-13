#!/bin/sh

# Set format options
FORMAT_UP='%{F#00FF00}'
FORMAT_DOWN='%{F#FF0000}'

MESSAGE_UP=$(\
    ip -4 -j addr show \
    | jq -r '[ 
        .[] | 
        select(.ifname | (startswith("tun") or startswith("wg"))) | 
        "\(.ifname) \(.addr_info[0].local)" 
      ] | join(", ")'
)

if [ -n "$MESSAGE_UP" ]; then
    echo "$FORMAT_UP$MESSAGE_UP"
else
    MESSAGE_DOWN='VPN down'
    echo "$FORMAT_DOWN$MESSAGE_DOWN"
fi
