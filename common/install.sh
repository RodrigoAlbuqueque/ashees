SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=true
LATESTARTSERVICE=true

REPLACE = "/system/vendor/overlay"

print_modname() {
ui_print "********************************" 
ui_print "            RealHard            "
ui_print "********************************"
}

MODULE_MIN_MAGISK_VERSION=26404
MODULE_MIN_KSU_KERNEL_VERSION=10940
MODULE_MIN_KSUD_VERSION=11412

enforce_install_from_app() {
  if $BOOTMODE; then
    ui_print "- Installing from Magisk / KernelSU app"
  else
    ui_print "*********************************************************"
    ui_print "! Install from recovery is NOT supported"
    ui_print "! Recovery sucks"
    ui_print "! Please install from Magisk / KernelSU app"
    abort "*********************************************************"
  fi
}

check_magisk_version() {
  ui_print "- Magisk version: $MAGISK_VER_CODE"
  if [ "$MAGISK_VER_CODE" -lt "$MODULE_MIN_MAGISK_VERSION" ]; then
    ui_print "*********************************************************"
    ui_print "! Please install Magisk $MODULE_MIN_MAGISK_VERSION_NAME (>$MODULE_MIN_MAGISK_VERSION)"
    abort    "*********************************************************"
  fi
}

check_ksu_version() {
  ui_print "- KernelSU version: $KSU_KERNEL_VER_CODE (kernel) + $KSU_VER_CODE (ksud)"
  if ! [ "$KSU_KERNEL_VER_CODE" ] || [ "$KSU_KERNEL_VER_CODE" -lt "$MODULE_MIN_KSU_KERNEL_VERSION" ]; then
    ui_print "*********************************************************"
    ui_print "! KernelSU version is too old!"
    ui_print "! Please update KernelSU to latest version"
    abort    "*********************************************************"
  elif [ "$KSU_KERNEL_VER_CODE" -ge 20000 ]; then
    ui_print "*********************************************************"
    ui_print "! KernelSU version abnormal!"
    ui_print "! Please integrate KernelSU into your kernel"
    ui_print "  as submodule instead of copying the source code"
    abort    "*********************************************************"
  fi
  if ! [ "$KSU_VER_CODE" ] || [ "$KSU_VER_CODE" -lt "$MODULE_MIN_KSUD_VERSION" ]; then
    ui_print "*********************************************************"
    ui_print "! ksud version is too old!"
    ui_print "! Please update KernelSU Manager to latest version"
    abort    "*********************************************************"
  fi
}

enforce_install_from_app
if [ "$KSU" ]; then
  check_ksu_version
else
  check_magisk_version
fi

# Android 12+ or newer
if [[ "$(getprop ro.build.version.sdk)" -lt 32 ]]; then
    ui_print ""
    ui_print "Functionality is limited on Android 12 and older."
    ui_print "Hardware-backed attestation will not be disabled."
    ui_print ""
fi

ui_print " Device Info "
sleep 1
  ui_print "  "
  ui_print "  "
  ui_print "  "
  ui_print " CODE NAME        : $(getprop ro.product.board) "
sleep 0.2
  ui_print " KERNEL           : $(uname -r) "
sleep 0.2  
  ui_print " VERSION GL       : $(getprop ro.opengles.version) "
sleep 0.2
  ui_print " SELINUX          : $(getprop ro.boot.selinux) "
sleep 0.2
  ui_print " BUILD DATE       : $(getprop ro.system.build.date) "
slepp 0.2
  ui_print " ANDROID VERSION  : $(getprop ro.system.build.version.release_or_codename) "
sleep 0.2
  ui_print " ROM              : $(getprop ro.build.flavor) "
sleep 0.2
  ui_print " DESCRIPTION ROM  : $(getprop ro.build.description) "
sleep 0.2
  ui_print " FINGERPRINT      : $(getprop ro.build.fingerprint) "
sleep 0.2
  ui_print " SECURITY PATCH   : $(getprop ro.build.version.security_patch) "
  ui_print "  "
  ui_print "  "
  ui_print "  "
sleep 1
  ui_print " Snapdragon "
sleep 1
  ui_print " "
  ui_print " RealHard @xda "
sleep 1
  ui_print " "
  ui_print " V 3.0.3 Demon Speed Edition "
sleep 1
  ui_print " "
  ui_print " su -c menu "
sleep 1  
  ui_print " "
  ui_print " Warning!! This module is high risk. 
  You should research it carefully before using it. 
  Do it at your own risk!! 
  Combination with other performance modules is not recommended. 
  Not responsible for anything at all "
sleep 1
  ui_print " "
sleep 1
  ui_print " Install Successfull !! "
sleep 1
  ui_print " "
  
# am start -a android.intent.action.VIEW -d https://t.me/Realhard_ProJect

on_install() {
   ui_print " Installing module please wait... "
   ui_print "           REALHARD               "

unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm_recursive $MODPATH/script 0 0 0755 0700
  set_perm $MODPATH/system/bin/menu 0 0 0755 0755
  set_perm $MODPATH/system/bin/CLEAN 0 0 0755 0755
  set_perm $MODPATH/system/bin/DON 0 0 0755 0755
  set_perm $MODPATH/system/bin/SON 0 0 0755 0755
  set_perm $MODPATH/system/bin/opengl 0 0 0755 0755
  set_perm $MODPATH/system/bin/skiagl 0 0 0755 0755
  set_perm $MODPATH/system/bin/skiavk 0 0 0755 0755
  set_perm $MODPATH/system/bin/vulkan 0 0 0755 0755
  set_perm $MODPATH/system/bin/daemon 0 0 0755
}
