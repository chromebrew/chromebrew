require 'buildsystems/autotools'

class Yelp < Autotools
  description 'Get help with GNOME'
  homepage 'https://wiki.gnome.org/Apps/Yelp'
  version "42.2-#{CREW_ICU_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/yelp.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e83dbae9ce30e16e0edd3fb170ab73d9e864561016356563bc5cfd8f56986ad',
     armv7l: '9e83dbae9ce30e16e0edd3fb170ab73d9e864561016356563bc5cfd8f56986ad',
     x86_64: '2f75e70e9bd8805acfe88a79e186ccc942e8910e75040f21d7aa92928a50fe18'
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
  depends_on 'py3_itstool' => :build
  depends_on 'libgcrypt' # R
  depends_on 'libgpg_error' # R
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
  depends_on 'zlib' # R

  gnome

  autotools_configure_options '--enable-compile-warnings=minimum \
    --enable-debug=no'
end
