# Adapted from Arch Linux cfitsio PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/cfitsio/trunk/PKGBUILD

require 'package'

class Cfitsio < Package
  description 'A library of C and Fortran subroutines for reading and writing data files in FITS Flexible Image Transport System data format'
  homepage 'https://heasarc.gsfc.nasa.gov/fitsio/'
  version '3.49'
  compatibility 'all'
  source_url 'https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-3.49.tar.gz'
  source_sha256 '5b65a20d5c53494ec8f638267fca4a629836b7ac8dd0ef0266834eab270ed4b3'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cfitsio-3.49-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cfitsio-3.49-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cfitsio-3.49-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cfitsio-3.49-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0d24de398a86b55b04f5601e856f872cccbe1e9d347bf918f7ad18af8bae776e',
     armv7l: '0d24de398a86b55b04f5601e856f872cccbe1e9d347bf918f7ad18af8bae776e',
       i686: '728f1602789e0eacf81236e0739d59dd27dca649c6c57a9c9947a730d0aa2d25',
     x86_64: '9957f638dd3ea9188ded8bbee7970955947784d51633033a3693ebb746158330'
  })

  def self.build
    system "sed -e 's|LDFLAGS=.*|LDFLAGS=$LDFLAGS|g' -i configure.in # Fix LDFLAGS"
    system 'autoreconf -vi'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} --enable-reentrant"
    system 'make shared'
    system 'make utils'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
