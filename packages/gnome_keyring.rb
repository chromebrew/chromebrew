require 'buildsystems/meson'

class Gnome_keyring < Meson
  description 'GNOME password and secret manager'
  homepage 'https://www.gnome.org'
  version '50.0'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-keyring.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '226f9a1c5611e12e79477bcb328717713e4c986ee98b73847fffe35965c95005',
     armv7l: '226f9a1c5611e12e79477bcb328717713e4c986ee98b73847fffe35965c95005',
     x86_64: '6f7f30c8941b5b62bfef4aa4c43e18476c6b95dead8efe4175c16297ec85fd72'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dconf' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'gcr_3' => :executable_only
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libcap' => :build
  depends_on 'libcap_ng' => :executable_only
  depends_on 'libeconf' # R
  depends_on 'libgcrypt' # R
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
