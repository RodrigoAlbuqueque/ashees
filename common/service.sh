#!/system/bin/sh
MODDIR=${0%/*}

# Reset props after boot completed to avoid breaking some weird devices/ROMs..
write() {
	[[ ! -f "$1" ]] && return 1
	chmod +w "$1" 2> /dev/null
	if ! echo "$2" > "$1" 2> /dev/null
	then
		echo "Failed: $1 → $2"
		return 1
	fi
}

sleep 20

# Disable LPM Parameters
for parameters in /sys/module/lpm_levels/parameters/*
do
    echo 0 > "$parameters/sleep_disabled"
    echo 0 > "$parameters/lpm_prediction"
    echo 0 > "$parameters/lpm_ipi_prediction"
done

# Configure LPM
echo N > /sys/module/lpm_levels/system/pwr/cpu0/ret/idle_enabled
echo N > /sys/module/lpm_levels/system/pwr/cpu1/ret/idle_enabled
echo N > /sys/module/lpm_levels/system/pwr/cpu2/ret/idle_enabled
echo N > /sys/module/lpm_levels/system/pwr/cpu3/ret/idle_enabled
echo N > /sys/module/lpm_levels/system/perf/cpu4/ret/idle_enabled
echo N > /sys/module/lpm_levels/system/perf/cpu5/ret/idle_enabled
echo N > /sys/module/lpm_levels/system/perf/cpu6/ret/idle_enabled
echo N > /sys/module/lpm_levels/system/perf/cpu7/ret/idle_enabled
echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-dynret/idle_enabled
echo N > /sys/module/lpm_levels/system/perf/perf-l2-dynret/idle_enabled
echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-ret/idle_enabled
echo N > /sys/module/lpm_levels/system/perf/perf-l2-ret/idle_enabled

#Tweak For Balance Cpu Core
echo 1 > /dev/cpuset/sched_relax_domain_level
echo 1 > /dev/cpuset/system-background/sched_relax_domain_level
echo 1 > /dev/cpuset/background/sched_relax_domain_level
echo 1 > /dev/cpuset/camera-background/sched_relax_domain_level
echo 1 > /dev/cpuset/foreground/sched_relax_domain_level
echo 1 > /dev/cpuset/top-app/sched_relax_domain_level
echo 1 > /dev/cpuset/restricted/sched_relax_domain_level
echo 1 > /dev/cpuset/asopt/sched_relax_domain_level
echo 1 > /dev/cpuset/camera-daemon/sched_relax_domain_level

# Change I/O Optimize
for queue in /sys/block/*/queue
do
    echo 0 > "$queue/iostats"
    echo deadline > "$queue/scheduler"
    echo 1024 > "$queue/read_ahead_kb"
done

# UFSPerformance
echo performance > /sys/class/devfreq/1d84000.ufshc/governor

# Force Thermal Dynamic Evaluation
chmod 0777 /sys/class/thermal/thermal_message/sconfig
echo 10 > /sys/class/thermal/thermal_message/sconfig
chmod 0444 /sys/class/thermal/thermal_message/sconfig

su -c settings put global private_dns_mode opportunistic
su -c settings put global smart_network_speed_distribution 1
su -c settings put global use_data_network_accelerate 1
su -c settings put global animator_duration_scale 0.0024999
su -c settings put global transition_animation_scale 0.0024999
su -c settings put global window_animation_scale 0.0024999
su -c cmd power set-fixed-performance-mode-enabled true
su -c settings put system power_mode high
# su -c settings put system speed_mode 1
su -c settings put secure speed_mode_enable 1
su -c settings put system thermal_limit_refresh_rate 1
su -c settings put system link_turbo_option 1
su -c settings put global transition_animation_duration_ratio 0.0024999
su -c settings put global block_untrusted_touches 0
su -c settings put global config_per_process_gpu_memory_fraction 0.9

# ข้อความ
su -lp 2000 -c "cmd notification post -S bigtext -t '🔥TWEAK🔥' 'Tag' 'Performance ⚡ปรับแต่ง⚡ Impover Overall Stability Successfull @RealHard️'"

# Bettery Friendly
echo Y > /sys/module/workqueue/parameters/power_efficient 
echo 200 > /sys/class/power_supply/bms/temp_cool
echo 460 > /sys/class/power_supply/bms/temp_hot
echo 300 > /sys/class/power_supply/bms/temp_warm

# Enable Fast Charge for slightly faster battery charging when being connected to a USB 3.1 port
echo 1 > /sys/kernel/fast_charge/force_fast_charge

# Disable scheduler statistics to reduce overhead
write /proc/sys/kernel/sched_schedstats 0

# We are not concerned with prioritizing latency
write /dev/stune/top-app/schedtune.prefer_idle 0

# Mark top-app as boosted, find high-performing CPUs
write /dev/stune/top-app/schedtune.boost 1

# Optimize SQLite settings for faster database access
echo pragma synchronous = off; > /data/local/tmp/sqlite_optimize.sql
sqlite3 /data/data/com.android.providers.settings/databases/settings.db < /data/local/tmp/sqlite_optimize.sql

# Apply changes
echo 0 > /proc/sys/kernel/randomize_va_space
echo 0 > /proc/sys/vm/compact_unevictable_allowed
echo 4 > /proc/sys/kernel/sched_pelt_multiplier
# echo 1 > /sys/class/kgsl/kgsl-3d0/thermal_pwrlevel

# Script
nohup sh $MODDIR/script/shellscript > /dev/null &

# Other commands or settings if required
sync && echo 3 > /proc/sys/vm/drop_caches
echo "Optimizations applied successfully!"

# Disable other unnecessary debugging options as per your needs
exit 0