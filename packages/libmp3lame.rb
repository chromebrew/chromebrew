require 'package'

class Libmp3lame < Package
  description 'LAME is a high quality MPEG Audio Layer III (MP3) encoder licensed under the LGPL.'
  homepage 'http://lame.sourceforge.net/'
  version '3.100'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz'
  source_sha256 'ddfe36cab873794038ae2c1210557ad34857a4b6bdc515785d1da9e175b1da1e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmp3lame-3.100-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmp3lame-3.100-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmp3lame-3.100-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmp3lame-3.100-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a707de2b17ad0cff139ad2441913bf2412d4c99287857d27deec98b8de44fe0d',
     armv7l: 'a707de2b17ad0cff139ad2441913bf2412d4c99287857d27deec98b8de44fe0d',
       i686: '3b9c5e437d2c230524ea0a6e7b676acc74b1e3f87d3a784eb57603b01679bbff',
     x86_64: '35a440b069c4734ec6c8100db2dfb541ceeddfbc96bb4aa176ebe2546c51d355',
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
