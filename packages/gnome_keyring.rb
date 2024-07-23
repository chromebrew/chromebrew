require 'buildsystems/autotools'

class Gnome_keyring < Autotools
  description 'GNOME password and secret manager'
  homepage 'https://www.gnome.org'
  version '46.1'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-keyring.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76e86060eceecc2f75f2a1f6c25f903e395fcb998dc5db8b7221ac98cdf94ae8',
      armv7l: '76e86060eceecc2f75f2a1f6c25f903e395fcb998dc5db8b7221ac98cdf94ae8',
      x86_64: 'ea6a16c27a7b38a967e2ea62ecb72a5b597460234b98a14581db62357ca60df9'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dconf' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'gcr_3' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libcap' => :build
  depends_on 'libcap_ng' # R
  depends_on 'libeconf' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpgerror' # R
  depends_on 'libxslt' => :build
  depends_on 'linux_pam' # R
  depends_on 'openssh' => :build
  depends_on 'p11kit' # R
  depends_on 'pango' # R
  depends_on 'zlibpkg' # R

  gnome

  configure_options "--with-pam-dir=#{CREW_PREFIX}/lib/security \
    --disable-selinux \
    --disable-schemas-compile \
    --disable-doc" # Docs cannot be used due to #4275
end
