require 'buildsystems/meson'

class Shotwell < Meson
  description 'An open-source digital photo organiser for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Shotwell'
  version '0.32.6'
  license 'GPL-2.1+'
  compatibility 'x86_64'
  source_url 'https://download.gnome.org/sources/shotwell/0.32/shotwell-0.32.6.tar.xz'
  source_sha256 '7597a4ffac91e18cd8144b12f2d08313a3f405bb368243a7326826f7d92a70b6'
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '264115379b4912399f66a9ee732c9cfabb682bb9d762c73e129add22f26d5146'
  })

  depends_on 'vala' => :build
  depends_on 'cairo' # R
  depends_on 'gcr' # R
  depends_on 'gdk_base' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gexiv2' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'libgee' # R
  depends_on 'libgphoto' # R
  depends_on 'libgudev' # R
  depends_on 'libportal' # R
  depends_on 'libraw' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'libwebp' # R
  depends_on 'libxml2' # R
  depends_on 'json_glib' # R
  depends_on 'py3_libxml2' # R
  depends_on 'sqlite' # R
  depends_on 'webkit2gtk' # R

  gnome
end
