require 'buildsystems/autotools'

class Cfitsio < Autotools
  description 'A library of C and Fortran subroutines for reading and writing data files in FITS Flexible Image Transport System data format'
  homepage 'https://heasarc.gsfc.nasa.gov/fitsio/'
  version '4.3.0'
  license 'ISC'
  compatibility 'all'
  source_url 'https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-4.3.0.tar.gz'
  source_sha256 '734ab0198714fe43eab94a67d6987085bde5573e6babde4d05799a8d04ebb04c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cfitsio/4.3.0_armv7l/cfitsio-4.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cfitsio/4.3.0_armv7l/cfitsio-4.3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cfitsio/4.3.0_i686/cfitsio-4.3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cfitsio/4.3.0_x86_64/cfitsio-4.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e20497a3684e21bf81000fc303fb0ade188df0f2068cc7918e0a534732d37a40',
     armv7l: 'e20497a3684e21bf81000fc303fb0ade188df0f2068cc7918e0a534732d37a40',
       i686: '8dadcdebac97e67bfe8f6f5fa8cfbc2cdf5a90e76015b69b0c47bd649f1d53bb',
     x86_64: 'ff5400768a004da517c07aa25334aec8e4caf4b7cc761202dba3b068913baf2b'
  })

  def self.patch
    system "sed -e 's|LDFLAGS=.*|LDFLAGS=$LDFLAGS|g' -i configure.in" # Fix LDFLAGS
  end

  def self.build
    system 'autoreconf -vi'
    system "CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} --enable-reentrant"
    system 'make shared'
    system 'make utils'
  end
end
