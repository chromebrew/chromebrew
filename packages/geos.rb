require 'package'

class Geos < Package
  description 'GEOS (Geometry Engine - Open Source) is a C++ port of the Java Topology Suite (JTS).'
  homepage 'https://trac.osgeo.org/geos/'
  version '3.6.2'
  source_url 'http://download.osgeo.org/geos/geos-3.6.2.tar.bz2'
  source_sha256 '045a13df84d605a866602f6020fc6cbf8bf4c42fb50de237a08926e1d7d7652a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/geos-3.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/geos-3.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/geos-3.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/geos-3.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e7dccaac206c59a018b7589ce8d4970cba051fa62cb3d43760ae73c74db7472b',
     armv7l: 'e7dccaac206c59a018b7589ce8d4970cba051fa62cb3d43760ae73c74db7472b',
       i686: '660067d29a33df264290f09f67d4c50e0c0a0a7ae292c64821aee9539cbf08bf',
     x86_64: 'bb64fb4244f867a29d47270a092733c310a15769d3e35db2c0ed95d5d59aaf53',
  })

  def self.build
    system './configure CFLAGS=" -fPIC"'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
