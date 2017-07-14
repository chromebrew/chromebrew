require 'package'

class Libpipeline < Package
  description 'libpipeline is a C library for manipulating pipelines of subprocesses in a flexible and convenient way.'
  homepage 'http://libpipeline.nongnu.org/'
  version '1.4.1-2'
  source_url 'https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.4.1.tar.gz'
  source_sha256 'da46d7b20163aadb9db2faae483f734e9096a7550c84b94029abeab62dd1b9ee'

  def self.build
    system './configure', "--libdir=#{CREW_LIB_PREFIX}", '--disable-static', '--enable-shared', '--with-pic'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
