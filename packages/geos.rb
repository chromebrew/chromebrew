require 'package'

class Geos < Package
  description 'GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS).'
  homepage 'https://trac.osgeo.org/geos/'
  version '3.6.1'
  source_url 'http://download.osgeo.org/geos/geos-3.6.1.tar.bz2'
  source_sha256 '4a2e4e3a7a09a7cfda3211d0f4a235d9fd3176ddf64bd8db14b4ead266189fc5'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/geos-3.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/geos-3.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/geos-3.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/geos-3.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8d2e7f75294f0cd00f3bcb38ee036593cc3e763406d181418a23d1adc27a694f',
     armv7l: '8d2e7f75294f0cd00f3bcb38ee036593cc3e763406d181418a23d1adc27a694f',
       i686: 'be6d488ae59d5ccf00a421dbe604cf171d8eeeaa28f9893016c29093855e91db',
     x86_64: '497af512e88361df4692a5fe7f2d405ea8d3ec061f387bb1af2df357b6e524b6',
  })

  def self.build
    system './configure CFLAGS=" -fPIC"'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
