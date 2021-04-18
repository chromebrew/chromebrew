#!/bin/bash
if [ ! -d ../packages ]; then
  echo 'Unable to locate packages directory.'
  exit 1
fi
cd ../packages
arch=$(uname -m)
exclusions='android_studio.rb antlr4.rb asciidoctor.rb asciinema.rb atom.rb autosetup.rb balena_etcher.rb brave.rb broadway.rb cabal.rb checkinstall.rb chrome.rb'
exclusions+=' clear_cache.rb codium.rb composer.rb cowsay.rb crew_profile.rb cros_resize.rb dart.rb depot_tools.rb docx2txt.rb dr.rb elixir.rb far.rb firefox.rb'
exclusions+=' flutter.rb fortune.rb fortunes.rb fpc.rb freebasic.rb freedos.rb gcc_tools.rb ghc.rb gittools.rb google_cloud_sdk.rb gradle.rb hugo.rb hunspell.rb'
exclusions+=' idea.rb julia.rb komodo.rb kotlin.rb kr.rb ld_default.rb leiningen.rb libtinfo.rb lsb_release.rb minecraft.rb mutagen.rb mysqltuner.rb mywanip.rb'
exclusions+=' nconvert.rb neofetch.rb netbeans.rb ngrok.rb nodebrew.rb nvm.rb oc.rb opera.rb packer.rb papirus_icon_theme.rb peazip.rb perl_gcstring_linebreak.rb'
exclusions+=' perl_io_socket_ssl.rb perl_locale_gettext.rb perl_locale_messages.rb perl_module_build.rb perl_read_key.rb perl_sgmls.rb perl_term_ansicolor.rb'
exclusions+=' perl_text_charwidth.rb perl_text_unidecode.rb perl_text_wrapi18n.rb perl_time_hires.rb perl_unicode_eastasianwidth.rb perl_xml_parser.rb'
exclusions+=' perl_xml_sax_parserfactory.rb perl_xml_simple.rb phpsysinfo.rb pipes_sh.rb pipesx_sh.rb platformsh.rb pngcheck.rb powershell.rb pup.rb pycharm.rb'
exclusions+=' qtcreator.rb skype.rb sl.rb sommelier.rb spark.rb squeak.rb stack.rb sublime_merge.rb sublime_text.rb symfony.rb telegram.rb terminus.rb terraform.rb'
exclusions+=' thefuck.rb tinycore.rb tkdiff.rb torbrowser.rb txt2regex.rb uthash.rb uwsgi.rb v2ray.rb vivaldi.rb wp_cli.rb xdg_base.rb xz_java.rb yarn.rb'
if [[ "${arch}" == 'aarch64' || "${arch}" == 'armv7l' ]]; then
  exclusions+=' az.rb brackets.rb cf.rb clisp.rb dropbox.rb fakeroot_ng.rb ghostscript.rb gitkraken.rb handbrake.rb hplip.rb igt_gpu_tools.rb jdk11.rb jdk15.rb'
  exclusions+=' libmfx.rb libva_intel_driver_hybrid.rb miniconda3.rb misctools.rb oci.rb nethack4.rb obs.rb prometheus_cpp.rb sbcl.rb shotcut.rb swi_prolog.rb'
  exclusions+=' weston.rb wing.rb wkhtmltox.rb xorg_intel_driver.rb xorg_intel_sdk.rb xorg_vmmouse_driver.rb'
fi
if [[ "${arch}" == 'i686' ]]; then
  exclusions+=' aqemu.rb codelite.rb dia.rb exa.rb fakeroot_ng.rb fzf.rb gcr.rb geany.rb geany_plugins.rb gemacs.rb gimp.rb gitkraken.rb gnome_keyring.rb'
  exclusions+=' gnome_session.rb gnome_shell.rb gtk_engines_adwaita.rb handbrake.rb heroku.rb imagemagick6.rb jdk11.rb jkd15.rb libgnome_keyring.rb librespot.rb'
  exclusions+=' libvncserver.rb mutter.rb neovim.rb pipewire.rb poppler.rb qtdeclarative.rb qtfm.rb qttools.rb ripgrep.rb sass.rb shotcut.rb tcpflow.rb wing.rb'
  exclusions+=' xorg_intel_driver.rb zathura.rb'
fi
if [[ "${arch}" == 'x86_64' ]]; then
  exclusions+=' libmfx.rb'
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
