require 'package'
 
class Libpipeline < Package
  description 'libpipeline is a C library for manipulating pipelines of subprocesses in a flexible and convenient way.'
  homepage 'http://libpipeline.nongnu.org/'
  version '1.4.2'
  source_url 'https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.4.2.tar.gz'
  source_sha1 '1967691198434f7bc78ffaa2ef6556ee60b0ca4a'
  
  def self.build
    system './configure', '--disable-static', '--enable-shared', '--with-pic'
    system 'make'
    system "find . -name 'lib*.so.*' -print | xargs strip -S"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make", "check"
  end
end
