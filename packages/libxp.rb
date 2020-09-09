require 'package'

class Libxp < Package
  description 'x print service extension library'
  homepage 'https://xorg.freedesktop.org'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/lib/libXp-1.0.3.tar.bz2'
  source_sha256 '7f360c9905849c3587d48efc0f0ecbc852c19f61a52b18530d6b005cb9148c57'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxp-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxp-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxp-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxp-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '173115a4b608b9234e3150d03fe8b41547878897c9a969e084950a72cd8ac633',
     armv7l: '173115a4b608b9234e3150d03fe8b41547878897c9a969e084950a72cd8ac633',
       i686: 'd3a75d68b62fca37ce490144e78d4fbf182cbb2aafb3433d0346ebe5cbfafdcd',
     x86_64: '4021f601179cdd9a62c551d9e131fd95a373535baeebc6eed166eb0dc7cd30ce',
  })

  depends_on 'xorg_proto'
  depends_on 'libxext'
  depends_on 'printproto'

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-malloc0returnsnull"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
