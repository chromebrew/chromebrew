require 'buildsystems/meson'

class Libwnck < Meson
  description 'Library for layout and rendering of text'
  homepage 'https://www.gnome.org/'
  version '43.2'
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libwnck.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc134e91938d22300daeae66b05351b70e95d32aaf4306500ba04f8ad02c442e',
     armv7l: 'dc134e91938d22300daeae66b05351b70e95d32aaf4306500ba04f8ad02c442e',
     x86_64: '591bc49671891c7fe0803ca1e6b9e6dbe36a79667cb6be15e16d5311ddb7bb9d'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxrender' # R
  depends_on 'libxres' # R
  depends_on 'pango' # R
  depends_on 'pygtk' => :build
  depends_on 'startup_notification' # R

  gnome
end
