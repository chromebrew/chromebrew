require 'buildsystems/meson'

class Libxfce4ui < Meson
  description 'Replacement of the old libxfcegui4 library'
  homepage 'https://docs.xfce.org/xfce/libxfce4ui/start'
  version '4.21.3'
  license 'LGPL-2+ and GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.xfce.org/xfce/libxfce4ui.git'
  git_hashtag "libxfce4ui-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc4c606d76072eb0848fbe7bd1c547fdb4743b0b9cc7303f38c988bde18f34fc',
     armv7l: 'dc4c606d76072eb0848fbe7bd1c547fdb4743b0b9cc7303f38c988bde18f34fc',
     x86_64: '10c84fc099465927f8da2f77b7e55d7fc6e66c9fa51afa1f60b83c2fca6d39ac'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3'
  depends_on 'harfbuzz' # R
  depends_on 'libice' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxfce4util' # R
  depends_on 'xfconf'

  meson_options '-Dintrospection=false'
end
