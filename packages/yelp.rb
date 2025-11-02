require 'buildsystems/meson'

class Yelp < Meson
  description 'Get help with GNOME'
  homepage 'https://wiki.gnome.org/Apps/Yelp'
  version "49.0-#{CREW_ICU_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/yelp.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2b5a55d307a9edb8d9ca776cef0fbdde26fe7a87a5c8c3aba3dfebbaf6d67d5',
     armv7l: 'e2b5a55d307a9edb8d9ca776cef0fbdde26fe7a87a5c8c3aba3dfebbaf6d67d5',
     x86_64: '05e74974cdb3d649990a92a88b48ee302bfcbf3c9556ed678b9d9b8852c9553c'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'bzip2' # R
  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'py3_itstool' => :build
  depends_on 'libadwaita' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpg_error' # R
  depends_on 'libhandy' # R
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'pango' # R
  depends_on 'sqlite' # R
  depends_on 'webkitgtk_6' # R
  depends_on 'xorg_server' => :build
  depends_on 'xzutils' # R
  depends_on 'yelp_xsl' => :build
  depends_on 'zlib' # R

  gnome
end
