require 'package'

class Sluice < Package
  description 'Sluice is a program that reads input on stdin and outputs on stdout at a specified data rate.'
  homepage 'http://kernel.ubuntu.com/~cking/sluice/'
  version '0.02.08'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/sluice/sluice-0.02.08.tar.gz'
  source_sha256 'c1fc8093f93bc376d494883f3302749fcf46a1041baab6c3304ef6185f9c1569'

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
