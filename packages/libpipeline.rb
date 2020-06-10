require 'package'

class Libpipeline < Package
  description 'libpipeline is a C library for manipulating pipelines of subprocesses in a flexible and convenient way.'
  homepage 'http://libpipeline.nongnu.org/'

  compatibility 'all'
  version '1.5.0'
  source_url 'https://mirror.csclub.uwaterloo.ca/nongnu/libpipeline/libpipeline-1.5.0.tar.gz'
  source_sha256 '0d72e12e4f2afff67fd7b9df0a24d7ba42b5a7c9211ac5b3dcccc5cd8b286f2b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpipeline-1.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpipeline-1.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpipeline-1.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpipeline-1.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b22c978f504de0e8356772bdb6c775a6d4b9760cb5422ab540a70940d63e8cab',
     armv7l: 'b22c978f504de0e8356772bdb6c775a6d4b9760cb5422ab540a70940d63e8cab',
       i686: '5ab87ee758833b15d55b680fee6742f27f26e25394feaeeca5d1c2d6e069b1d5',
     x86_64: '9cefcb70b634fa7d1ff081794712ca4e1448e0dbfd57d0be411bbef2a149bd78',
  })

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
