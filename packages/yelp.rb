require 'package'

class Yelp < Package
  description 'Get help with GNOME'
  homepage 'https://wiki.gnome.org/Apps/Yelp'
  version '40.0'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/yelp/-/archive/#{version}/yelp-#{version}.tar.bz2"
  source_sha256 'ec640d7a56970ab3ac6283d6c3a90ae45b7676c739671b303cbfb2f4323bf7af'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '021a5a25255e9bd5c5f44fe170abc70bb18ecd6b72a5a312da295c1c2831420b',
     armv7l: '021a5a25255e9bd5c5f44fe170abc70bb18ecd6b72a5a312da295c1c2831420b',
     x86_64: '33ef261b6056265b6fa65b81c3fef50f8c5792f7e70ace0639d65f453a7f2f69'
  })

  depends_on 'appstream_glib'
  depends_on 'at_spi2_core'
  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'harfbuzz'
  depends_on 'libsoup2'
  depends_on 'libxslt'
  depends_on 'pango'
  depends_on 'webkit2gtk'
  depends_on 'yelp_xsl'
  depends_on 'gtk_doc' => :build
  depends_on 'itstool' => :build
  depends_on 'xorg_server' => :build

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env #{CREW_ENV_OPTIONS} \
    ./configure #{CREW_OPTIONS} \
    --enable-compile-warnings=minimum \
    --enable-debug=no \
    --disable-dependency-tracking"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
