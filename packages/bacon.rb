require 'package'

class Bacon < Package
  version '3.5.1'
  source_url 'http://www.basic-converter.org/stable/bacon-3.5.1.tar.gz'
  source_sha1 '13a90fa76a07edf36e4a4e5b242b60479a0eccc3'

  def self.build
    system "./configure --prefix=/usr/local --without-gui"
    system 'sed -i "45s,/usr/share,/usr/local/share," Makefile'
    system 'sed -i "46s,/usr/share,/usr/local/share," Makefile'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
