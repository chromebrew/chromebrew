require 'package'

class Libsigcplusplus3 < Package
  description 'libsigc++ implements a typesafe callback system for standard C++.'
  homepage 'http://libsigc.sourceforge.net/'
  version '2.99.11'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libsigc++/2.99/libsigc++-2.99.11.tar.xz'
  source_sha256 '177fb08df33da71780eef2ce4c5991a2b3b6d07d4ad1efbf6ad38f7964e4bb55'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus3-2.99.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus3-2.99.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus3-2.99.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus3-2.99.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '37cc07ba4469b7975214cf2bdb8fed2665962353318888386907f96f08dc9f95',
     armv7l: '37cc07ba4469b7975214cf2bdb8fed2665962353318888386907f96f08dc9f95',
       i686: '86a3fed7a036dbcfed62bfd4b83e903d3cc78f241a793546f07af00fc3855d2b',
     x86_64: 'e0fb98d028040eb6567a153c1314bd51fb044d4f7cf1c2cfaf4cb4d672a31130',
  })

  def self.build
    system './configure',
           "CXX_FLAGS=' --std=c++14'",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
