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
  ui_print " V 3.0.8 Performance For Rider "
sleep 1
  ui_print " "
  ui_print " Optimization "
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
