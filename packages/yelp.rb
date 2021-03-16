require 'package'

class Yelp < Package
  description 'Get help with GNOME'
  homepage 'https://wiki.gnome.org/Apps/Yelp'
  @_ver = '40.rc'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/GNOME/yelp/archive/#{@_ver}.tar.gz"
  source_sha256 '57cecf29edbe7b5701e5c21c345fe4492503e2c87fb7cc5ef4257b5fd77f8bde'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp-40.rc-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yelp-40.rc-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yelp-40.rc-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp-40.rc-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cfe4fb78c87d69ef4380e094c32dc3609fff239f506ef31db4d45d2400fadf82',
     armv7l: 'cfe4fb78c87d69ef4380e094c32dc3609fff239f506ef31db4d45d2400fadf82',
       i686: '3976c9f34a6edba4a43b35475e2ca9dfdffc885c8fa33f5d55da5a106d629d42',
     x86_64: 'c476142c4a8ae47c3ffde56e6d931544707f8e88fb1dd44c409030a018812c56'
  })

  depends_on 'webkit2gtk'
  depends_on 'yelp_xsl'
  depends_on 'libxslt'
  depends_on 'appstream_glib'

  depends_on 'gtk_doc' => ':build'
  depends_on 'itstool' => ':build'
  depends_on 'xorg_server' => ':build'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --enable-compile-warnings=minimum \
    --enable-debug=no \
    --disable-dependency-tracking"
    # Documentation generation segfaults without X11"
    # system "xvfb-run -s '-screen 0 1920x1080x24 -nolisten local' make"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
