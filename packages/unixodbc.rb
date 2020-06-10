require 'package'

class Unixodbc < Package
  description 'ODBC is an open specification for providing application developers with a predictable API with which to access Data Sources.'
  homepage 'http://www.unixodbc.org/'
  version '2.3.7'
  compatibility 'all'
  source_url 'http://www.unixodbc.org/unixODBC-2.3.7.tar.gz'
  source_sha256 '45f169ba1f454a72b8fcbb82abd832630a3bf93baa84731cf2949f449e1e3e77'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/unixodbc-2.3.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/unixodbc-2.3.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/unixodbc-2.3.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/unixodbc-2.3.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4d97ddf6e1d78b18f90fa8ee4e8698a2c10e111cd294c6a4ee479b0ba734a1b8',
     armv7l: '4d97ddf6e1d78b18f90fa8ee4e8698a2c10e111cd294c6a4ee479b0ba734a1b8',
       i686: '987033a506015196dee6951e25d0860a23c5deadf74068590be5b913d1bfca3d',
     x86_64: 'ecae202a4367725ceb7124b374f5e80335cfde85b6cdc296beaff735ddea3331',
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
