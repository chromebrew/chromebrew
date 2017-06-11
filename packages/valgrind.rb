require 'package'

class Valgrind < Package
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'http://valgrind.org/'
  version '3.12.0'
  source_url 'http://valgrind.org/downloads/valgrind-3.12.0.tar.bz2'
  source_sha1 '7a6878bf998c60d1e377a4f22ebece8d9305bda4'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
