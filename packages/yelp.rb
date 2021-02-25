require 'package'

class Yelp < Package
  description 'Get help with GNOME'
  homepage 'https://wiki.gnome.org/Apps/Yelp'
  @_ver = '40.beta'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/GNOME/yelp/archive/#{@_ver}.tar.gz"
  source_sha256 '7e4716182f368be298c0cf8c6963c2731a21b8def17612b5b05f36230747e6dd'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yelp-40.beta-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yelp-40.beta-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yelp-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9adf9c294d016bb777e5e9cfff6a38edc44ee26fd6b68900db05df01e7f63ad0',
     armv7l: '9adf9c294d016bb777e5e9cfff6a38edc44ee26fd6b68900db05df01e7f63ad0',
       i686: 'a84bde1a08b64269c8a29f70538c869bb8fa8a7890df74b2a0535063279310a5',
     x86_64: 'e0c245e4c2683219ba37118040a1c2dfc60e71a4d45a21aa611633291f0e1121'
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
