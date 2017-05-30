require 'package'

class Sluice < Package
  description 'Sluice is a program that reads input on stdin and outputs on stdout at a specified data rate.'
  homepage 'http://kernel.ubuntu.com/~cking/sluice/'
  version '0.02.06'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/sluice/sluice-0.02.06.tar.gz'
  source_sha1 'c1afc98790147c2c48bc5675de8352812b4f1fea'

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
