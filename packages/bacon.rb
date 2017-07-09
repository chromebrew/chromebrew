require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.5.4'
  source_url 'http://www.basic-converter.org/stable/bacon-3.5.4.tar.gz'
  source_sha256 '7b1c72fd46daaa43d19e1bfac2f9bcd9decc5b8443d8f5640e903bfc35e122b9'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/bacon-3.5.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/bacon-3.5.4-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/bacon-3.5.4-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/bacon-3.5.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3415da0b1303b42ef2b2b4385a9aec58f02ae237b05e857f4bbb1807290a5b41',
     armv7l: '3415da0b1303b42ef2b2b4385a9aec58f02ae237b05e857f4bbb1807290a5b41',
       i686: '2cf7f4c550c50898fbadeabb792e2dc22423532e20241967e193c97fd138d767',
     x86_64: '023778b5d5ccbbd276bd97a49077633ca5c8c249778b0cfce2a720d74f0efc66',
  })

  def self.build
    system "./configure --prefix=/usr/local --disable-gui"
    system 'sed -i "45s,/usr/share,/usr/local/share," Makefile'
    system 'sed -i "46s,/usr/share,/usr/local/share," Makefile'

    # force to compile in sequential since bacon Makefile doesn't work in parallel
    system "make", "-j1"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
