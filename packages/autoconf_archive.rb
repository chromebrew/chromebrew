require 'package'

class Autoconf_archive < Package
  description 'GNU Autoconf Archive is a collection of freely re-usable Autoconf macros.'
  homepage 'https://www.gnu.org/software/autoconf-archive/'
  version '2018.03.13'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-2018.03.13.tar.xz'
  source_sha256 '6175f90d9fa64c4d939bdbb3e8511ae0ee2134863a2c7bf8d9733819efa6e159'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf_archive-2018.03.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf_archive-2018.03.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf_archive-2018.03.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf_archive-2018.03.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f2088e6174f98043cfddf9b2d96441289df11734427ae9dc6c59da75422aaba4',
     armv7l: 'f2088e6174f98043cfddf9b2d96441289df11734427ae9dc6c59da75422aaba4',
       i686: 'bfcbaf73dcf68c5300971711f423a4479e9aa414e41c7017cbf664d0eeec1a56',
     x86_64: 'd8f31ce241d96ada48f8edc66580ae283b34b3257fea86abfee35d2af25e046a',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
