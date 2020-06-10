require 'package'

class Tre < Package
  description 'The approximate regex matching library and agrep command line tool.'
  homepage 'https://github.com/laurikari/tre'
  version '6fb7206'
  compatibility 'all'
  source_url 'https://github.com/laurikari/tre/archive/6fb7206b935b35814c5078c20046dbe065435363.tar.gz'
  source_sha256 'd2810576685b10c6bf9270793550032bdada04afd963fa4670a08fdc57859bdd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tre-6fb7206-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tre-6fb7206-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tre-6fb7206-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tre-6fb7206-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6c59cddabc2dd32d56b97b48b32fca26cb654b453cb3c8089bc50cd78266e217',
     armv7l: '6c59cddabc2dd32d56b97b48b32fca26cb654b453cb3c8089bc50cd78266e217',
       i686: '54c589df47bf9822b6e14b67d10a03457989bcb532a3ea899d2619a8e602f539',
     x86_64: 'b5d531c2f83c53fb1f54c5b658bb67fb875e16183a9cdc2c4d5a03cf7e091130',
  })

  def self.build
    system './utils/autogen.sh'
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
