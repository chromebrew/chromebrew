require 'package'

class Gutenprint < Package
  description 'High quality drivers for Canon, Epson, Lexmark, Sony, Olympus, and PCL printers for use with CUPS and GIMP.'
  homepage 'http://gimp-print.sourceforge.net/'
  version '5.3.3'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/gimp-print/gutenprint-5.3/5.3.3/gutenprint-5.3.3.tar.xz'
  source_sha256 '7279ecbc8e67d1858c53cb24e423ea1be98e214872006b79e6e03650dd54a072'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gutenprint-5.3.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gutenprint-5.3.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gutenprint-5.3.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gutenprint-5.3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '881b8199d6167bcf0a8008cff249e6bf2a792d1711d10a302e7e853e2fecfb2f',
     armv7l: '881b8199d6167bcf0a8008cff249e6bf2a792d1711d10a302e7e853e2fecfb2f',
       i686: 'af03ca9c9904c2c5970aa89e4074c338ea525fd165c1872f3f473e4e43531379',
     x86_64: '08e10a199a709b9078abaee3a3ccbfb380adfe68c411b7d824c7e143d8a67b5d',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
