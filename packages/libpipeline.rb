require 'package'

class Libpipeline < Package
  description 'libpipeline is a C library for manipulating pipelines of subprocesses in a flexible and convenient way.'
  homepage 'http://libpipeline.nongnu.org/'

  version '1.5.0'
  source_url 'https://mirror.csclub.uwaterloo.ca/nongnu/libpipeline/libpipeline-1.5.0.tar.gz'
  source_sha256 '0d72e12e4f2afff67fd7b9df0a24d7ba42b5a7c9211ac5b3dcccc5cd8b286f2b'

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
