#!/system/bin/sh
MODDIR=${0%/*}

# Optimization
{
while true; do
        resetprop  -n persist.sys.power.default.powermode high
        resetprop  -n persist.sys.turbosched.enable true
        resetprop  -n persist.sys.turbosched.enable.coreApp.optimizer true
        resetprop  -n persist.sys.turbosched.gaea.enable true
        
        sleep 1;
    done
} &

# Disable CPU frequency throttling
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/interactive/; do
    echo 0 > "${cpu}enable_freq_resp"
    echo 0 > "${cpu}boost"
done

exit 0
