function bluetooth () {
    system_profiler SPBluetoothDataType | grep -E "Battery|Services" | sed "s/Services://g" | sed "s/Battery Level://g" | sed "s/Apple Wireless//g" | sed -e 's/^[ \t]*//' | paste -d" " - - 2>/dev/null
}
