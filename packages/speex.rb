require 'package'

class Speex < Package
  description 'Speex is an Open Source/Free Software patent-free audio compression format designed for speech.'
  homepage 'https://speex.org/'
  version '1.2.0-1'
  compatibility 'all'
  source_url 'http://downloads.us.xiph.org/releases/speex/speex-1.2.0.tar.gz'
  source_sha256 'eaae8af0ac742dc7d542c9439ac72f1f385ce838392dc849cae4536af9210094'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/speex-1.2.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/speex-1.2.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/speex-1.2.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/speex-1.2.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5e1bba6a53dd827dd342a7e28454080025e8f3f7c8bd4766004a2da3f9842678',
     armv7l: '5e1bba6a53dd827dd342a7e28454080025e8f3f7c8bd4766004a2da3f9842678',
       i686: 'dea00b220cacfa50c244dee46977c0827008b7e831ace2abd6a97d2ab7d3cfe1',
     x86_64: '868c4f618a5a0679ce908774963b73d630b7dddc1b9256fede1aa26c0b09a5d5',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
