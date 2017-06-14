require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.5.3'
  source_url 'http://www.basic-converter.org/stable/bacon-3.5.3.tar.gz'
  source_sha1 'd88cc452d0580309e106f692639293ef2c249f58'

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
