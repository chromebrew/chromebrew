require 'package'

class Hdf5 < Package
  description 'HDF5 is a unique technology suite that makes possible the management of extremely large and complex data collections.'
  homepage 'https://www.hdfgroup.org/'
  version '1.10.5'
  compatibility 'all'
  source_url 'https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.5/src/hdf5-1.10.5.tar.bz2'
  source_sha256 '68d6ea8843d2a106ec6a7828564c1689c7a85714a35d8efafa2fee20ca366f44'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hdf5-1.10.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hdf5-1.10.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hdf5-1.10.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hdf5-1.10.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e1f92f38039d13d530ef8dee9f0c2bf3ddb9be9be3a60adee6bb82dc87a62a3a',
     armv7l: 'e1f92f38039d13d530ef8dee9f0c2bf3ddb9be9be3a60adee6bb82dc87a62a3a',
       i686: 'd56fe7f4f5e7234fad92a98cd081a812d07f4906c190ba3d615c1a14ca188957',
     x86_64: '258e724a97f0943a940f1b8663a591efeff11ffc507ca51ecd0ffe38b3997fdb',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--disable-static'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
