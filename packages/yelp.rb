require 'buildsystems/autotools'

class Yelp < Autotools
  description 'Get help with GNOME'
  homepage 'https://wiki.gnome.org/Apps/Yelp'
  version '42.2'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/yelp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c8da5f26d6abe29c64093dc18a9a218e1e8b7a3b3b9ea31a4195d7493f1d1508',
     armv7l: 'c8da5f26d6abe29c64093dc18a9a218e1e8b7a3b3b9ea31a4195d7493f1d1508',
     x86_64: 'bdbd52b3ca8c5e795fdc0943c002beab2032bde20e9a4ebf1372dbb5fbf88481'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'bzip2' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'itstool' => :build
  depends_on 'libgcrypt' # R
  depends_on 'libgpgerror' # R
  depends_on 'libhandy' # R
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'pango' # R
  depends_on 'sqlite' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'xorg_server' => :build
  depends_on 'xzutils' # R
  depends_on 'yelp_xsl' => :build
  depends_on 'zlibpkg' # R

  gnome

  configure_options '--enable-compile-warnings=minimum \
    --enable-debug=no'
end
