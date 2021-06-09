#!/bin/bash
if [ ! -d ../packages ]; then
  echo 'Unable to locate packages directory.'
  exit 1
fi
cd ../packages
arch=$(uname -m)
exclusions='android_studio.rb antlr4.rb asciidoctor.rb asciinema.rb atom.rb autosetup.rb balena_etcher.rb brave.rb broadway.rb cabal.rb checkinstall.rb chrome.rb'
exclusions+=' clear_cache.rb codium.rb composer.rb cowsay.rb cpu_x.rb crew_profile.rb cros_resize.rb dart.rb depot_tools.rb docx2txt.rb dr.rb elixir.rb far.rb'
exclusions+=' fd.rb firefox.rb flutter.rb fortune.rb fortunes.rb fpc.rb freebasic.rb freecad.rb freedos.rb gcc_tools.rb gcloud.rb ghc.rb gittools.rb gradle.rb'
exclusions+=' hollywood.rb hugo.rb hunspell.rb idea.rb julia.rb keepassxc.rb komodo.rb kotlin.rb kr.rb ld_default.rb leiningen.rb libtinfo.rb lsb_release.rb'
exclusions+=' minecraft.rb mutagen.rb mysqltuner.rb mywanip.rb nconvert.rb neofetch.rb netbeans.rb ngrok.rb nodebrew.rb nvm.rb oc.rb opera.rb packer.rb pakitheme.rb'
exclusions+=' papirus_icon_theme.rb peazip.rb perl_gcstring_linebreak.rb perl_io_socket_ssl.rb perl_locale_gettext.rb perl_locale_messages.rb perl_module_build.rb'
exclusions+=' perl_read_key.rb perl_sgmls.rb perl_term_ansicolor.rb perl_text_charwidth.rb perl_text_unidecode.rb perl_text_wrapi18n.rb perl_time_hires.rb'
exclusions+=' perl_unicode_eastasianwidth.rb perl_xml_parser.rb perl_xml_sax_parserfactory.rb perl_xml_simple.rb phpsysinfo.rb pipes_sh.rb pipesx_sh.rb pkgsrc.rb'
exclusions+=' platformsh.rb pngcheck.rb powershell.rb pup.rb pycharm.rb qtcreator.rb ruby_docopt.rb skype.rb sl.rb sommelier.rb spark.rb squeak.rb stack.rb'
exclusions+=' sublime_merge.rb sublime_text.rb symfony.rb telegram.rb terminus.rb terraform.rb thefuck.rb tinycore.rb tkdiff.rb torbrowser.rb txt2regex.rb'
exclusions+=' uthash.rb uwsgi.rb v2ray.rb vivaldi.rb wallstreet.rb wp_cli.rb xdg_base.rb xz_java.rb yarn.rb'
if [[ "${arch}" == 'aarch64' || "${arch}" == 'armv7l' ]]; then
  exclusions+=' az.rb blender.rb brackets.rb cf.rb clisp.rb crossmobile.rb darktable.rb dropbox.rb fakeroot_ng.rb ghostscript.rb gitkraken.rb handbrake.rb hplip.rb'
  exclusions+=' igt_gpu_tools.rb intel_media_driver.rb intel_media_sdk.rb jdk11.rb jdk15.rb libmfx.rb libva_intel_driver_hybrid.rb miniconda3.rb misctools.rb mysql.rb'
  exclusions+=' oci.rb openhab.rb nethack4.rb obs.rb prometheus_cpp.rb sbcl.rb shotcut.rb svt_av1.rb swi_prolog.rb weston.rb wing.rb wkhtmltox.rb xorg_intel_driver.rb'
  exclusions+=' xorg_intel_sdk.rb xorg_vmmouse_driver.rb'
fi
if [[ "${arch}" == 'i686' ]]; then
  exclusions+=' aqemu.rb blender.rb codelite.rb crossmobile.rb darktable.rb dia.rb epiphany.rb exa.rb fakeroot_ng.rb fzf.rb gcr.rb geany.rb geany_plugins.rb gemacs.rb'
  exclusions+=' gimp.rb gitkraken.rb gnome_keyring.rb gnome_session.rb gnome_shell.rb gtk_engines_adwaita.rb handbrake.rb heroku.rb imagemagick6.rb intel_media_driver.rb'
  exclusions+=' intel_media_sdk.rb jdk11.rb jdk15.rb libgnome_keyring.rb librespot.rb libvncserver.rb mutter.rb mysql.rb neovim.rb openhab.rb pipewire.rb poppler.rb'
  exclusions+=' qtdeclarative.rb qtfm.rb qttools.rb ripgrep.rb sass.rb shotcut.rb svt_av1.rb t1lib.rb tcpflow.rb wing.rb xorg_intel_driver.rb zathura.rb zig.rb'
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
