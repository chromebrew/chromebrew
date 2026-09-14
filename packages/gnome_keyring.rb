require 'buildsystems/meson'

class Gnome_keyring < Meson
  description 'GNOME password and secret manager'
  homepage 'https://www.gnome.org'
  version '51.0'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-keyring.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f68de1623127c9cdcd7fbaaf6416d791e843d0288a94c8c6fac2e786678e0717',
     armv7l: 'f68de1623127c9cdcd7fbaaf6416d791e843d0288a94c8c6fac2e786678e0717',
     x86_64: 'c4c6ccdbdabeadc98a4752716aafda65bc970f39e408d10d3b7b72c11d2052e9'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dconf' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'gcr_3' => :executable
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libcap' => :build
  depends_on 'libcap_ng' => :executable
  depends_on 'libeconf' # R
  depends_on 'libgcrypt' => :library
  depends_on 'libgpg_error' # R
  depends_on 'libxslt' => :build
  depends_on 'openssh' => :build
  depends_on 'p11kit' # R
  depends_on 'pango' # R
  depends_on 'zlib' # R

  gnome

  meson_options "-D{debug-mode,manpage,pam,ssh-agent}=false \
                -D{selinux,systemd}=disabled"
end
