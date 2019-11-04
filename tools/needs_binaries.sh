#!/bin/bash
if [ ! -d ../packages ]; then
  echo 'Unable to locate packages directory.'
  exit 1
fi
cd ../packages
arch=$(uname -m)
exclusions='android_studio.rb antlr4.rb asciinema.rb autosetup.rb broadway.rb cabal.rb checkinstall.rb codium.rb composer.rb cowsay.rb'
exclusions+=' crew_profile.rb cros_resize.rb docx2txt.rb dr.rb elixir.rb far.rb fortune.rb fortunes.rb fpc.rb freedos.rb gcc_tools.rb'
exclusions+=' ghc.rb gittools.rb google_cloud_sdk.rb gradle.rb hugo.rb hunspell.rb julia.rb komodo.rb kr.rb ld_default.rb leiningen.rb'
exclusions+=' libtinfo.rb lsb_release.rb mysqltuner.rb nconvert.rb neofetch.rb ngrok.rb nodebrew.rb nvm.rb oc.rb packer.rb perl_gcstring_linebreak.rb'
exclusions+=' perl_io_socket_ssl.rb perl_locale_gettext.rb perl_locale_messages.rb perl_module_build.rb perl_read_key.rb perl_sgmls.rb'
exclusions+=' perl_term_ansicolor.rb perl_text_charwidth.rb perl_text_unidecode.rb perl_text_wrapi18n.rb perl_time_hires.rb'
exclusions+=' perl_unicode_eastasianwidth.rb perl_xml_parser.rb perl_xml_sax_parserfactory.rb perl_xml_simple.rb pipes_sh.rb'
exclusions+=' pipesx_sh.rb pngcheck.rb qtcreator.rb sl.rb spark.rb stack.rb sublime_merge.rb sublime_text.rb thefuck.rb tinycore.rb'
exclusions+=' tkdiff.rb txt2regex.rb uwsgi.rb v2ray.rb wp_cli.rb xdg_base.rb yarn.rb'
if [[ "${arch}" == 'aarch64' || "${arch}" == 'armv7l' ]]; then
  exclusions+=' az.rb cf.rb clisp.rb dropbox.rb fakeroot_ng.rb freebasic.rb miniconda3.rb misctools.rb oci.rb weston.rb wkhtmltox.rb'
  exclusions+=' xorg_intel_driver.rb xorg_vmmouse_driver.rb'
fi
if [[ "${arch}" == 'i686' ]]; then
  exclusions+=' fakeroot_ng.rb'
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
