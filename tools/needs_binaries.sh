#!/bin/bash
if [ ! -d ../packages ]; then
  echo 'Unable to locate packages directory.'
  exit 1
fi
cd ../packages
arch=$(uname -m)
exclusions='android_studio.rb antlr4.rb asciidoctor.rb asciinema.rb autosetup.rb brave.rb broadway.rb cabal.rb checkinstall.rb clear_cache.rb codium.rb composer.rb'
exclusions+=' cowsay.rb crew_profile.rb cros_resize.rb dart.rb depot_tools.rb docx2txt.rb dr.rb elixir.rb far.rb firefox.rb flutter.rb fortune.rb fortunes.rb'
exclusions+=' fpc.rb freebasic.rb freedos.rb gcc_tools.rb ghc.rb gittools.rb google_cloud_sdk.rb gradle.rb hugo.rb hunspell.rb idea.rb julia.rb'
exclusions+=' komodo.rb kotlin.rb kr.rb ld_default.rb leiningen.rb libtinfo.rb lsb_release.rb mutagen.rb mysqltuner.rb nconvert.rb neofetch.rb netbeans.rb'
exclusions+=' ngrok.rb nodebrew.rb nvm.rb oc.rb packer.rb papirus_icon_theme.rb perl_gcstring_linebreak.rb perl_io_socket_ssl.rb perl_locale_gettext.rb'
exclusions+=' perl_locale_messages.rb perl_module_build.rb perl_read_key.rb perl_sgmls.rb perl_term_ansicolor.rb perl_text_charwidth.rb perl_text_unidecode.rb'
exclusions+=' perl_text_wrapi18n.rb perl_time_hires.rb perl_unicode_eastasianwidth.rb perl_xml_parser.rb perl_xml_sax_parserfactory.rb'
exclusions+=' perl_xml_simple.rb pipes_sh.rb pipesx_sh.rb platformsh.rb pngcheck.rb powershell.rb pycharm.rb qtcreator.rb sl.rb spark.rb squeak.rb'
exclusions+=' stack.rb sublime_merge.rb sublime_text.rb symfony.rb terminus.rb terraform.rb thefuck.rb tinycore.rb tkdiff.rb txt2regex.rb uthash.rb uwsgi.rb'
exclusions+=' v2ray.rb wp_cli.rb xdg_base.rb xz_java.rb yarn.rb'
if [[ "${arch}" == 'aarch64' || "${arch}" == 'armv7l' ]]; then
  exclusions+=' atom.rb az.rb cf.rb brackets.rb clisp.rb dropbox.rb fakeroot_ng.rb ghostscript.rb gitkraken.rb handbrake.rb hplip.rb miniconda3.rb'
  exclusions+=' misctools.rb oci.rb nethack4.rb obs.rb opera.rb sbcl.rb skype.rb weston.rb wing.rb wkhtmltox.rb xorg_intel_driver.rb'
  exclusions+=' xorg_vmmouse_driver.rb'
fi
if [[ "${arch}" == 'i686' ]]; then
  exclusions+=' aqemu.rb atom.rb codelite.rb cras.rb dia.rb exa.rb fakeroot_ng.rb gcr.rb geany.rb gemacs.rb gimp.rb gitkraken.rb gnome_keyring.rb gtk_engines_adwaita.rb'
  exclusions+=' handbrake.rb imagemagick6.rb imagemagick7.rb libgnome_keyring.rb librespot.rb libvncserver.rb neovim.rb opera.rb ripgrep.rb rust.rb skype.rb tcpflow.rb'
  exclusions+=' wing.rb xorg_intel_driver.rb'
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
