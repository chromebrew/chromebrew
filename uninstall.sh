#!/bin/sh -e

crew list installed | sed '/ruby/d' | tr '\n' ' ' > /usr/local/tmp/installed.vGGdhY
printf 'crew remove ' > /usr/local/tmp/remove.vGGdhY
printf '#!/bin/bash'"\n" > /usr/local/tmp/header.vGGdhY
cat /usr/local/tmp/header.vGGdhY /usr/local/tmp/remove.vGGdhY /usr/local/tmp/installed.vGGdhY > /usr/local/tmp/uninstall.vGGdhY
chmod a+rwx /usr/local/tmp/uninstall.vGGdhY
/usr/local/tmp/uninstall.vGGdhY
crew remove ruby
rm -rf /usr/local/bin/crew /usr/local/tmp/crew /usr/local/etc/crew /usr/local/tmp/crew 
rm /usr/local/tmp/*.vGGdhY
