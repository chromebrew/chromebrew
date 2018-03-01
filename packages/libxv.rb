require 'package'

class Libxv < Package
  description 'X.org X Window System video extension library'
  homepage 'http://www.x.org'
  version '1.0.11'
  source_url 'https://www.x.org/archive/individual/lib/libXv-1.0.11.tar.gz'
  source_sha256 'c4112532889b210e21cf05f46f0f2f8354ff7e1b58061e12d7a76c95c0d47bb1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxv-1.0.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxv-1.0.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxv-1.0.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxv-1.0.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de4608c1e342f9fc192238daccbc75ec33e777bf0a618d196dca079cbe079a63',
     armv7l: 'de4608c1e342f9fc192238daccbc75ec33e777bf0a618d196dca079cbe079a63',
       i686: '50fd60825ca1d54958153c0a68d5595a040c15d8d4ad3b84edb0511da0d5a9ed',
     x86_64: '9b7da69a2936fdc07509824391a795840f7c2bc77b7b8b7de32f7a51a0232c21',
  })

  depends_on 'videoproto'
  depends_on 'libxext'
  depends_on 'libx11'
  depends_on 'xextproto'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end