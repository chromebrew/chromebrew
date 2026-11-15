require 'buildsystems/meson'

class Yelp < Meson
  description 'Get help with GNOME'
  homepage 'https://wiki.gnome.org/Apps/Yelp'
  version "49.2-#{CREW_ICU_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/yelp.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf9467d0a8819c149dc100dfab7ff3e3c1a2fad2b8392a24c89d0d8b7aa44b4f',
     armv7l: 'bf9467d0a8819c149dc100dfab7ff3e3c1a2fad2b8392a24c89d0d8b7aa44b4f',
     x86_64: '84cce26548c78ac9d08e4fe3df032e8a7a0b67277ca5b7576d1169e15b26774e'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'bzip2' => :library
  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
