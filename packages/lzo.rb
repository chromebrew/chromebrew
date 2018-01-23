require 'package'

class Lzo < Package
  description 'LZO is a portable lossless data compression library written in ANSI C.'
  homepage 'http://www.oberhumer.com/opensource/lzo/'
  version '2.10'
  source_url 'http://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz'
  source_sha256 'c0f892943208266f9b6543b3ae308fab6284c5c90e627931446fb49b4221a072'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lzo-2.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lzo-2.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lzo-2.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lzo-2.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '48f35f97fe737685e654e162b95deac81332f347de457a5e264e4b01a7b48c6d',
     armv7l: '48f35f97fe737685e654e162b95deac81332f347de457a5e264e4b01a7b48c6d',
       i686: '062344694ca8cd0fcd90b3c9ce24e699fe1492d4e76f88663ae850f7ac3b5984',
     x86_64: 'af956b6de9567424e26283996b2e3e0b10b3c86992ffb09e6c53d3bb7411b5ba',
  })

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-dependency-tracking \
            --disable-maintainer-mode"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
