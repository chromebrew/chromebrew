require 'package'

class Valgrind < Package
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'http://valgrind.org/'
  version '3.13.0'
  source_url 'ftp://sourceware.org/pub/valgrind/valgrind-3.13.0.tar.bz2'
  source_sha1 'ddf13e22dd0ee688bd533fc66b94cf88f75fad86'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
