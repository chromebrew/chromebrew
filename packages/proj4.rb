require 'package'

class Proj4 < Package
  description 'proj.4 is a standard Unix filter function which converts geographic longitude and latitude coordinates into cartesian coordinates (and vice versa), and it is a C API for software developers to include coordinate transformation in their own software.'
  homepage 'http://proj4.org/'
  version '4.9.3'
  source_url 'http://download.osgeo.org/proj/proj-4.9.3.tar.gz'
  source_sha256 '6984542fea333488de5c82eea58d699e4aff4b359200a9971537cd7e047185f7'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/proj4-4.9.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/proj4-4.9.3-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/proj4-4.9.3-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/proj4-4.9.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6c947a6a2d31f284e57caebb97ef7869add2eab2b22d1f6eb6e7a8be0f1cb7bc',
     armv7l: '6c947a6a2d31f284e57caebb97ef7869add2eab2b22d1f6eb6e7a8be0f1cb7bc',
       i686: '3631813cd417d72fd51a947db19e9680dadc62ecd15c2012856b7d91890776c0',
     x86_64: '1d3b6566117201b8853eaa35d535574f6d1bfb780dfff0d969923a42b8975ae0',
  })

  def self.build
    system './configure CFLAGS=" -fPIC"'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
