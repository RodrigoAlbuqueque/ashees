SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=true
LATESTARTSERVICE=true

REPLACE = "/system/vendor/overlay"

print_modname() {
ui_print "********************************" 
ui_print "     PERFORMANCE FOR RIDER      "
ui_print "********************************"
}

am start -a android.intent.action.VIEW -d https://t.me/PROJECT_RealHard

on_install() {
   ui_print " Installing module please wait... "
   ui_print " Dual status bar by: REALHARD     "

unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm_recursive $MODPATH/script 0 0 0755 0700
  set_perm $MODPATH/system/bin/CLEAN 0 0 0755 0755
  set_perm $MODPATH/system/bin/DON 0 0 0755 0755
  set_perm $MODPATH/system/bin/SON 0 0 0755 0755
  set_perm $MODPATH/system/bin/daemon 0 0 0755
}
