StopInstalling() {
  rm -rf $MODPATH >/dev/null 2>&1
  rm -rf $TMPDIR >/dev/null 2>&1
  exit 1
}

# set destination folder
target_dir=$(pwd)

# switch to system folder
cd /system/vendor/etc/

# create target folder
mkdir -p "$MODPATH/system/vendor/etc/"

number_of_files=0;

# Copy all files starting with "thermal-" and ending with ".conf" to the target folder, and write empty files
for file in thermal-*.conf; do
    number_of_files=`expr $number_of_files + 1`
    cp "$file" "$MODPATH/system/vendor/etc/"
    echo -n "" > "$MODPATH/system/vendor/etc/$file"
done

if [ "$number_of_files" -eq "0" ]; then
    ui_print "- This module is not applicable to your device"
    ui_print "- The module installer is about to be stopped"
    StopInstalling
else
    ui_print "- A total of $number_of_files temperature control files"
fi

# Credits @https://t.me/modulostk


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
  ui_print " V 3.1.0 Performance For Rider "
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
unzip -o "$ZIPFILE" 'script/*' -d $MODPATH >&2
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
