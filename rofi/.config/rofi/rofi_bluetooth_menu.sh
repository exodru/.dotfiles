#!/usr/bin/env bash

notify-send "Getting list of available Bluetooth devices..."

# Get a list of paired and available Bluetooth devices
# We'll parse 'bluetoothctl devices' and 'bluetoothctl paired-devices'
# to get a clear list.
bluetooth_devices_raw=$(bluetoothctl devices)
bluetooth_paired_raw=$(bluetoothctl paired-devices)

declare -A device_names
declare -A device_macs
device_list=""

# Parse paired devices first
while IFS= read -r line; do
    if [[ $line =~ Device\ ([0-9A-Fa-f:]{17})\ (.*) ]]; then
        mac="${BASH_REMATCH[1]}"
        name="${BASH_REMATCH[2]}"
        device_names["$mac"]="$name"
        device_macs["$name"]="$mac"
        device_list+="P $name ($mac)\n" # 'P' for paired
    fi
done <<< "$bluetooth_paired_raw"

# Parse general devices, add only if not already paired
while IFS= read -r line; do
    if [[ $line =~ Device\ ([0-9A-Fa-f:]{17})\ (.*) ]]; then
        mac="${BASH_REMATCH[1]}"
        name="${BASH_REMATCH[2]}"
        if [[ -z "${device_names[$mac]}" ]]; then # Only add if not already in paired list
            device_names["$mac"]="$name"
            device_macs["$name"]="$mac"
            device_list+="A $name ($mac)\n" # 'A' for available
        fi
    fi
done <<< "$bluetooth_devices_raw"


# Check Bluetooth power status
bluetooth_power_status=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
if [[ "$bluetooth_power_status" == "yes" ]]; then
    toggle="󰂯  Disable Bluetooth"
    scan_option="󰂰  Scan for Devices"
    paired_devices_option="󰂱  Show Paired Devices"
    disconnect_all_option="󰂲  Disconnect All Devices"
elif [[ "$bluetooth_power_status" == "no" ]]; then
    toggle="󰂯  Enable Bluetooth"
    scan_option="" # No scan option if disabled
    paired_devices_option=""
    disconnect_all_option=""
fi

# Build the rofi menu options
rofi_options="$toggle"
if [[ -n "$scan_option" ]]; then
    rofi_options+="\n$scan_option"
fi
if [[ -n "$paired_devices_option" ]]; then
    rofi_options+="\n$paired_devices_option"
fi
if [[ -n "$disconnect_all_option" ]]; then
    rofi_options+="\n$disconnect_all_option"
fi
if [[ -n "$device_list" ]]; then
    rofi_options+="\n--- Devices ---" # Separator
    rofi_options+="\n$device_list"
fi

# Use rofi to select Bluetooth action/device
chosen_action=$(echo -e "$rofi_options" | uniq -u | rofi -dmenu -i -selected-row 0 -p "Bluetooth: ")

# Handle chosen action
if [ "$chosen_action" = "" ]; then
    exit
elif [ "$chosen_action" = "$toggle" ]; then
    if [[ "$bluetooth_power_status" == "yes" ]]; then
        bluetoothctl power off && notify-send "Bluetooth" "Bluetooth disabled."
    else
        # --- ADDED PART START ---
        notify-send "Bluetooth" "Attempting to enable Bluetooth and resolve soft block..."

        # Unblock Bluetooth via rfkill (requires sudo)
        sudo rfkill unblock bluetooth
        if [ $? -eq 0 ]; then
            notify-send "Bluetooth" "Bluetooth unblocked via rfkill."
        else
            notify-send "Bluetooth Error" "Failed to unblock Bluetooth via rfkill. Password might be needed."
        fi

        # Restart Bluetooth service (requires sudo)
        sudo systemctl restart bluetooth
        if [ $? -eq 0 ]; then
            notify-send "Bluetooth" "Bluetooth service restarted."
        else
            notify-send "Bluetooth Error" "Failed to restart Bluetooth service. Password might be needed."
        fi

        # Now try to power on Bluetooth
        bluetoothctl power on && notify-send "Bluetooth" "Bluetooth enabled." || notify-send "Bluetooth Error" "Failed to power on Bluetooth."
        # --- ADDED PART END ---
    fi
elif [ "$chosen_action" = "$scan_option" ]; then
    notify-send "Bluetooth" "Scanning for devices (will run for 10 seconds)..."
    bluetoothctl scan on &
    SCAN_PID=$!
    sleep 10
    bluetoothctl scan off
    kill $SCAN_PID 2>/dev/null # Kill the background scan process if it's still running
    notify-send "Bluetooth" "Scan complete. Re-run menu to see new devices."
elif [ "$chosen_action" = "$paired_devices_option" ]; then
    paired_devices_output=$(bluetoothctl paired-devices | awk '{print $3 " (" $2 ")"}' | sed '/^$/d')
    if [[ -z "$paired_devices_output" ]]; then
        notify-send "Bluetooth" "No paired devices found."
    else
        echo -e "--- Paired Devices ---\n$paired_devices_output" | rofi -dmenu -i -p "Paired Devices"
    fi
elif [ "$chosen_action" = "$disconnect_all_option" ]; then
    bluetoothctl devices Connected | grep "Device" | while read -r _ _ mac _; do
        bluetoothctl disconnect "$mac" && notify-send "Bluetooth" "Disconnected from $mac"
    done
    notify-send "Bluetooth" "Attempted to disconnect from all connected devices."
else
    # It's a device. Extract name and MAC
    # Handles both "P Name (MAC)" and "A Name (MAC)"
    if [[ "$chosen_action" =~ [PA]\ (.+)\ \(([0-9A-Fa-f:]{17})\) ]]; then
        chosen_name="${BASH_REMATCH[1]}"
        chosen_mac="${BASH_REMATCH[2]}"

        notify-send "Bluetooth" "Attempting to connect/pair with $chosen_name ($chosen_mac)..."

        # Check if already connected
        connected_status=$(bluetoothctl info "$chosen_mac" | grep "Connected:" | awk '{print $2}')

        if [[ "$connected_status" == "yes" ]]; then
            # If connected, offer disconnect
            bluetoothctl disconnect "$chosen_mac" && notify-send "Bluetooth" "Disconnected from $chosen_name"
        else
            # Try to pair first if not paired
            is_paired=$(bluetoothctl info "$chosen_mac" | grep "Paired:" | awk '{print $2}')
            if [[ "$is_paired" == "no" ]]; then
                notify-send "Bluetooth" "Pairing with $chosen_name..."
                bluetoothctl pair "$chosen_mac"
                # If pairing fails, the connect command will likely fail too
                if [ $? -ne 0 ]; then
                    notify-send "Bluetooth Error" "Pairing failed for $chosen_name."
                    exit 1
                fi
            fi

            # Connect
            bluetoothctl connect "$chosen_mac" && notify-send "Bluetooth" "Connected to $chosen_name" || notify-send "Bluetooth Error" "Failed to connect to $chosen_name."
        fi
    else
        notify-send "Bluetooth Error" "Unknown selection: $chosen_action"
    fi
fi
