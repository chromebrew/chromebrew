require 'buildsystems/meson'

class Yelp < Meson
  description 'Get help with GNOME'
  homepage 'https://wiki.gnome.org/Apps/Yelp'
  version "49.1-#{CREW_ICU_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/yelp.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b3c7035e8892c05f9f3fe9afdf5b0b61b12f5d6ddc90ddaeee3a2f5ae12bac2',
     armv7l: '9b3c7035e8892c05f9f3fe9afdf5b0b61b12f5d6ddc90ddaeee3a2f5ae12bac2',
     x86_64: '8e38a28defdbc26bb131f9f5c68391e55e9cee5fea309438077095bc0be1790c'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'bzip2' => :library
  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gtk4' => :library
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libadwaita' => :library
  depends_on 'libgcrypt' # R
  depends_on 'libgpg_error' # R
  depends_on 'libhandy' # R
  depends_on 'libsoup' # R
  depends_on 'libxml2' => :library
  depends_on 'libxslt' => :library
  depends_on 'pango' # R
  depends_on 'py3_itstool' => :build
  depends_on 'sqlite' # R
  depends_on 'webkitgtk_6' => :library
  depends_on 'xorg_server' => :build
  depends_on 'xzutils' => :library
  depends_on 'yelp_xsl' => :build
  depends_on 'zlib' # R

  gnome
end
