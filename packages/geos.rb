require 'package'

class Geos < Package
  description 'GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS).'
  homepage 'https://trac.osgeo.org/geos/'
  version '3.6.2-1'
  compatibility 'all'
  source_url 'https://download.osgeo.org/geos/geos-3.6.2.tar.bz2'
  source_sha256 '045a13df84d605a866602f6020fc6cbf8bf4c42fb50de237a08926e1d7d7652a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/geos-3.6.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/geos-3.6.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/geos-3.6.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/geos-3.6.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '03ec890596017cdc2eec50487ecb45d51cd2b271cdf21ee4ec9f1086af90baa1',
     armv7l: '03ec890596017cdc2eec50487ecb45d51cd2b271cdf21ee4ec9f1086af90baa1',
       i686: '8248bcc085845f536b886dd47bc66ee8b0e9e948d46239bc8f462fbdc8a9f46e',
     x86_64: '08279556bb8b28bf5436c8abe1bc127e33f97e9a3cfa65b9a307a65a02dabf87',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
