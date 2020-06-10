require 'package'

class Proj4 < Package
  description 'proj.4 is a standard Unix filter function which converts geographic longitude and latitude coordinates into cartesian coordinates (and vice versa), and it is a C API for software developers to include coordinate transformation in their own software.'
  homepage 'http://proj4.org/'
  version '5.0.1'
  compatibility 'all'
  source_url 'https://download.osgeo.org/proj/proj-5.0.1.tar.gz'
  source_sha256 'a792f78897482ed2c4e2af4e8a1a02e294c64e32b591a635c5294cb9d49fdc8c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/proj4-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/proj4-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/proj4-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/proj4-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '11f68ce43489194bb71a8ade3b97200b3cb3b3cb11657225b65aee352daddeeb',
     armv7l: '11f68ce43489194bb71a8ade3b97200b3cb3b3cb11657225b65aee352daddeeb',
       i686: '02628ae6d77c32d20d873a78210804b5824ea2705c898e6b983f03ae80d9bdef',
     x86_64: '7a95e9781c0f6ab0c6a9086988a58e72eff016a803cb0a2c249eb8862b51be34',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
