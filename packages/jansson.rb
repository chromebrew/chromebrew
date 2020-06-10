require 'package'

class Jansson < Package
  description 'Jansson is a C library for encoding, decoding and manipulating JSON data.'
  homepage 'http://www.digip.org/jansson/'
  version '2.12'
  compatibility 'all'
  source_url 'https://github.com/akheron/jansson/archive/v2.12.tar.gz'
  source_sha256 '76260d30e9bbd0ef392798525e8cd7fe59a6450c54ca6135672e3cd6a1642941'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1268da5b1e8fb780fa300e2435992978ad3ca1dca671fcb157591795b219cee3',
     armv7l: '1268da5b1e8fb780fa300e2435992978ad3ca1dca671fcb157591795b219cee3',
       i686: '1a5b9a9099cb64e5b097090bc17a0ae3b225c66815dd06f3db0a32d4adedac03',
     x86_64: '3cb0754c45a3997f7c41cc0d941964c4ec55f12e28792712ececc2d5f41a42e4',
  })

  def self.build
    system 'autoreconf -i'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
