require 'package'

class Proj4 < Package
  description 'proj.4 is a standard Unix filter function which converts geographic longitude and latitude coordinates into cartesian coordinates (and vice versa), and it is a C API for software developers to include coordinate transformation in their own software.'
  homepage 'http://proj4.org/'
  version '6.3.2'
  compatibility 'all'
  source_url 'https://download.osgeo.org/proj/proj-6.3.2.zip'
  source_sha256 '5ef90382d1d57e7185d13064fa46c1f6350a079f4f7ad67c862b6075ca7b88ec'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/proj4-6.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/proj4-6.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/proj4-6.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/proj4-6.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bde7e31699f5ed4348dbd36b5f5b3c2712c1fcee49f27531c4d900e38d043e69',
     armv7l: 'bde7e31699f5ed4348dbd36b5f5b3c2712c1fcee49f27531c4d900e38d043e69',
       i686: '5c4a089119c9f9a362a0bbe13b6f6982cb08cc469c678dde694a8ec181415efc',
     x86_64: 'bf6f5ee5af25517619680631c3bfb79aad84ebc5acfd00be404a35ebe3b9ff95',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
