require 'buildsystems/meson'

class Libwnck < Meson
  description 'Library for layout and rendering of text'
  homepage 'http://www.gnome.org/'
  version '43.0'
  license 'LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libwnck.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c093d0bb27d5152c0d7809c306ea7c805621982d2ba9e740f5bff9612dc131b',
     armv7l: '0c093d0bb27d5152c0d7809c306ea7c805621982d2ba9e740f5bff9612dc131b',
     x86_64: '3fe193834abace0b6694327a6069ed7a04d88d5d1d465c4cd839289aac8e355d'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
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
