require 'package'

class Ragel < Package
  description 'Ragel compiles executable finite state machines from regular languages.'
  homepage 'http://www.colm.net/open-source/ragel/'
  version '6.10'
  compatibility 'all'
  source_url 'https://www.colm.net/files/ragel/ragel-6.10.tar.gz'
  source_sha256 '5f156edb65d20b856d638dd9ee2dfb43285914d9aa2b6ec779dac0270cd56c3f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ragel-6.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ragel-6.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ragel-6.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ragel-6.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2efdeff57b498308def95b8fb8ac9efdc232909b245d0a8522a4259f82d9767c',
     armv7l: '2efdeff57b498308def95b8fb8ac9efdc232909b245d0a8522a4259f82d9767c',
       i686: '238950153c3a07bd9465f20918b26bc9986fc45ce97936d739a8bf25edcf7de6',
     x86_64: 'dcb064549487d9ba7916e83ff4676673b9f2b01a437cd31d162c34a8b5fe1597',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
