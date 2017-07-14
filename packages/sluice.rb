require 'package'

class Sluice < Package
  description 'Sluice is a program that reads input on stdin and outputs on stdout at a specified data rate.'
  homepage 'http://kernel.ubuntu.com/~cking/sluice/'
  version '0.02.06'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/sluice/sluice-0.02.06.tar.gz'
  source_sha256 'a1f06c2e7077e28fedb2b4f82066f6e6396bbd2fb4e8f22ef219ff573cdbe163'

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
