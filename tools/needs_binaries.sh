#!/bin/bash
if [ ! -d ../packages ]; then
  echo "Unable to locate packages directory."
  exit 1
fi
cd ../packages
arch=$(uname -m)
exclusions="antlr4.rb asciinema.rb autosetup.rb cabal.rb code.rb composer.rb crew_profile.rb cros_resize.rb"
exclusions+=" docx2txt.rb dpkg.rb dr.rb far.rb fpc.rb freedos.rb ghc.rb julia.rb kr.rb libtinfo.rb lsb_release.rb"
exclusions+=" mysqltuner.rb nodebrew.rb nvm.rb oc.rb spark.rb stack.rb thefuck.rb txt2regex.rb uwsgi.rb xdg_base.rb yarn.rb"
if [[ "$arch" == "aarch64" || "$arch" == "armv7l" ]]; then
  exclusions+=" cbase.rb cf.rb clisp.rb dmidecode.rb dropbox.rb freebasic.rb google_cloud_sdk.rb lldb.rb mesa.rb"
  exclusions+=" miniconda3.rb misctools.rb oci.rb qt.rb wkhtmltox.rb"
fi
packages=$(grep -L "$arch:" *.rb)
for p in $packages; do
  include=1
  for e in $exclusions; do
    if [ "$e" == "$p" ]; then
      include=
      break
    fi
  done
  if test $include; then
    grep -L is_fake $p
  fi
done
