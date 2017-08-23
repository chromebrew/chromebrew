require 'package'

class Libpipeline < Package
  description 'libpipeline is a C library for manipulating pipelines of subprocesses in a flexible and convenient way.'
  homepage 'http://libpipeline.nongnu.org/'

  version '1.4.2'
  source_url 'https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.4.2.tar.gz'
  source_sha256 'fef1fc9aa40ce8796f18cd1aecd888a9484a9556c8b0f8d07c863578277679be'

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
