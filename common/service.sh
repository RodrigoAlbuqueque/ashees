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

for queue in /sys/block/*/queue
do
    echo 0 > "$queue/iostats"
    echo deadline > "$queue/scheduler"
    echo 0 > "$queue/rq_affinity"
    #echo 1024 > "$queue/read_ahead_kb"
done

for gov in /sys/devices/system/cpu/*/cpufreq/*
do
   echo 99 > "$gov/hispeed_load"
   echo 1 > "$gov/boost"
done

#echo disabled > /sys/class/thermal/thermal_zone*/mode
echo 0 > /sys/class/kgsl/kgsl-3d0/throttling
echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable

for a in $(getprop|grep thermal|cut -f1 -d]|cut -f2 -d[|grep -F init.svc.|sed 's/init.svc.//');do stop $a;done;for b in $(getprop|grep thermal|cut -f1 -d]|cut -f2 -d[|grep -F init.svc.);do setprop $b stopped;done;for c in $(getprop|grep thermal|cut -f1 -d]|cut -f2 -d[|grep -F init.svc_);do setprop $c "";done

su -c settings put system miui_app_cache_optimization 1
su -c settings put global touch_response_time 0
#su -c settings put global animator_duration_scale 0.0024999
#su -c settings put global transition_animation_scale 0.0024999
#su -c settings put global window_animation_scale 0.0024999
su -c settings delete global transition_animation_duration_ratio

su -lp 2000 -c "cmd notification post -S bigtext -t '🔥TWEAK🔥' 'Tag' 'VTEC_Dynamic ⚡ปรับแต่ง⚡ Impover Overall Stability Successfull @RealHard️'"

nohup sh $MODDIR/script/shellscript > /dev/null &
sync && echo 3 > /proc/sys/vm/drop_caches
echo "Optimizations applied successfully!"
