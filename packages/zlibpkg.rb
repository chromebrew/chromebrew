require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'http://www.zlib.net/'
  version '1.2.11-1'
  source_url 'http://www.zlib.net/zlib-1.2.11.tar.gz'
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/zlibpkg-1.2.11-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/zlibpkg-1.2.11-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/zlibpkg-1.2.11-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/zlibpkg-1.2.11-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b9fea1db11323af7101be1a5abbbad91e4f7ac8b90c2faa663d51ded9fd189f5',
     armv7l: 'b9fea1db11323af7101be1a5abbbad91e4f7ac8b90c2faa663d51ded9fd189f5',
       i686: '88fd4195cdb279dd7e4ef5c88a934b9e466710325142eb6f1b7f55b06ce32ff9',
     x86_64: '451f231b181b174cfe1638d4319258b526cccf58d0b1622a8b4d55600bc67b82',
  })

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # remove static library since there is no configuration option to not create it.
    system "rm", "#{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/libz.a"
  end

  def self.check
    system "make check"
  end
end
