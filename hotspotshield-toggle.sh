#!/bin/bash

vpn_status() {
    vpn_status=$(hotspotshield status | grep "VPN connection state" | awk '{print $5}')
    echo $vpn_status 
}

toggle_vpn() {
    current_vpn_status=$(vpn_status)
    if [ "$current_vpn_status" == "disconnected" ]
        then
        hotspotshield connect
        confirm_vpn_status_change
    else
        hotspotshield disconnect
        confirm_vpn_status_change
    fi
}

confirm_vpn_status_change() {
    while true
        do
        current_vpn_status=$(vpn_status)
        if [ "$current_vpn_status" == "connected" ] || [ "$current_vpn_status" == "disconnected" ]
            then
            echo $current_vpn_status
            break
        else
            sleep 0.25
        fi
    done
}

toggle_vpn