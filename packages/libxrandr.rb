require 'package'

class Libxrandr < Package
  description 'X.org X Resize, Rotate and Reflection extension library'
  homepage 'http://www.x.org'
  version '1.5.1'
  source_url 'https://www.x.org/archive/individual/lib/libXrandr-1.5.1.tar.gz'
  source_sha256 '2baa7fb3eca78fe7e11a09b373ba898b717f7eeba4a4bfd68187e04b4789b0d3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ce4a37a03adeeea36096c183113824de7178a1c7c5511d706c5f789485640676',
     armv7l: 'ce4a37a03adeeea36096c183113824de7178a1c7c5511d706c5f789485640676',
       i686: '48dbeb74bd37f378f292b3fd027698d0d66ffff7c3e54c7e3efa57f288970b34',
     x86_64: 'fb19adcd935509790fccff7b874204240cf70b91ed67b60d2ea2eb5aeeb65a13',
  })

  depends_on 'libxrender'
  depends_on 'randrproto'
  depends_on 'libx11'
   
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end