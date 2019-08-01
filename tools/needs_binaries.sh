#!/bin/bash
if [ ! -d ../packages ]; then
  echo 'Unable to locate packages directory.'
  exit 1
fi
cd ../packages
arch=$(uname -m)
exclusions='antlr4.rb asciinema.rb autosetup.rb broadway.rb cabal.rb checkinstall.rb composer.rb cowsay.rb crew_profile.rb cros_resize.rb'
exclusions+=' docx2txt.rb dr.rb far.rb fortune.rb fortunes.rb fpc.rb freedos.rb ghc.rb google_cloud_sdk.rb gradle.rb julia.rb komodo.rb'
exclusions+=' kr.rb ld_default.rb libtinfo.rb lsb_release.rb mysqltuner.rb nodebrew.rb nvm.rb oc.rb pipes_sh.rb pipesx_sh.rb pngcheck.rb'
exclusions+=' qt.rb sl.rb spark.rb stack.rb sublime_merge.rb sublime_text.rb thefuck.rb tinycore.rb txt2regex.rb uwsgi.rb xdg_base.rb yarn.rb'
exclusions+=' neofetch.rb perl_gcstring_linebreak.rb perl_io_socket_ssl.rb perl_locale_gettext.rb perl_locale_messages.rb perl_module_build.rb'
exclusions+=' perl_read_key.rb perl_sgmls.rb perl_term_ansicolor.rb perl_text_charwidth.rb perl_text_unidecode.rb perl_text_wrapi18n.rb'
exclusions+=' perl_time_hires.rb perl_unicode_eastasianwidth.rb perl_xml_parser.rb perl_xml_sax_parserfactory.rb perl_xml_simple.rb'
exclusions+=' leiningen.rb v2ray.rb linux_sources.rb'
if [[ "${arch}" == 'aarch64' || "${arch}" == 'armv7l' ]]; then
  exclusions+=' az.rb cf.rb clisp.rb dropbox.rb freebasic.rb miniconda3.rb misctools.rb oci.rb wkhtmltox.rb xorg_intel_driver.rb xorg_vmmouse_driver.rb'
fi
packages=$(grep -L "${arch}:" *.rb)
for p in ${packages}; do
  include=1
  for e in ${exclusions}; do
    if [ "${e}" == "${p}" ]; then
      include=
      break
    fi
  done
  if [[ -n "${include}" ]]; then
    grep -L is_fake ${p}
  fi
done
