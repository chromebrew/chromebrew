require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'http://www.zlib.net/'
  version '1.2.11-2'
  source_url 'http://www.zlib.net/zlib-1.2.11.tar.gz'
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # remove static library since there is no configuration option to not create it.
    system "rm", "#{CREW_DEST_LIB_PREFIX}/libz.a"
  end

  def self.check
    system "make check"
  end
end
