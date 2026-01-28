require 'buildsystems/meson'

class Gnome_keyring < Meson
  description 'GNOME password and secret manager'
  homepage 'https://www.gnome.org'
  version '48.0'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-keyring.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80fbcad4639279749bab1a2bd844b6a068fd6514bca1ebc8a32c5150f5eb2dcc',
     armv7l: '80fbcad4639279749bab1a2bd844b6a068fd6514bca1ebc8a32c5150f5eb2dcc',
     x86_64: '9be4397fdabacbc130128fdbc2d1c398faf11fee24bfe20ae943d97c7dd4aaa3'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dconf' => :build
  depends_on 'docbook_xml' => :build
  depends_on 'gcr_3' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libcap' => :build
  depends_on 'libcap_ng' # R
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
