#!/system/bin/sh
MODDIR=${0%/*}

# Optimization
write /proc/sys/kernel/sched_pelt_multiplier 2

{
while true; do
        resetprop  -n persist.sys.power.default.powermode balanced
        resetprop  -n kernel.default.powermode balanced
        sleep 1;
    done
} &

# Toggle 3D and Rendering Optimization
TOGGLE_3D=1
TOGGLE_RENDERING=1

# Set 3D and Rendering Optimization values
if [ "$TOGGLE_3D" -eq 1 ]; then
    # Set 3D Optimization variables
    GL_TEXTURE_SIZE=4096
    GL_TEXTURE_MAX_ANISOTROPY=16

    # Set 3D Optimization
    # setprop ro.sf.lcd_density 420
    setprop debug.sf.tc_or 1
    setprop debug.egl.hw 1
    setprop debug.sf.hw 1
    setprop persist.sys.composition.type gpu
    setprop ro.surface_flinger.max_texture_size "$GL_TEXTURE_SIZE"
    setprop ro.vendor.extension_library libqti-perfd-client.so
    setprop qemu.hw.mainkeys 0
    setprop persist.sys.ui.hw true
    setprop persist.sys.force_highendgfx true
    setprop debug.gpu.egl.recordable true
    setprop debug.egl.handover 1
    setprop debug.egl.max_texture_size "$GL_TEXTURE_SIZE"
    setprop debug.egl.swapinterval -1
    setprop debug.egl.texture_max_level 0
    setprop debug.egl.texture_size "$GL_TEXTURE_SIZE"
    setprop debug.egl.texture_max_anisotropy "$GL_TEXTURE_MAX_ANISOTROPY"
fi

# Set Rendering Optimization
if [ "$TOGGLE_RENDERING" -eq 1 ]; then
    # setprop ro.fb.color_format RGB_565
    setprop persist.sys.use_16bpp_alpha true
    setprop debug.egl.use_16bpp_alpha true
    setprop debug.egl.disable_gl_yuv true
    setprop debug.composition.type gpu
fi

# Set the rendering thread priority to a high value
echo -17 > /proc/$$/taskset/cpuset/camera-daemon/cgroup.sched_boost

# Disable CPU frequency throttling
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/interactive/; do
    echo 0 > "${cpu}enable_freq_resp"
    echo 0 > "${cpu}boost"
done

exit 0
