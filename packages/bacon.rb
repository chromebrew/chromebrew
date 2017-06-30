require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.5.4'
  source_url 'http://www.basic-converter.org/stable/bacon-3.5.4.tar.gz'
  source_sha256 '7b1c72fd46daaa43d19e1bfac2f9bcd9decc5b8443d8f5640e903bfc35e122b9'

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
