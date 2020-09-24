require 'package'

class Netcdf < Package
  description 'NetCDF is a set of software libraries and self-describing, machine-independent data formats that support the creation, access, and sharing of array-oriented scientific data.'
  homepage 'https://www.unidata.ucar.edu/software/netcdf/'
  version '4.7.4'
  compatibility 'all'
  source_url 'https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-4.7.4.tar.gz'
  source_sha256 '0e476f00aeed95af8771ff2727b7a15b2de353fb7bb3074a0d340b55c2bd4ea8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/netcdf-4.7.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/netcdf-4.7.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/netcdf-4.7.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/netcdf-4.7.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0023e30b23e00619fdfef8d497d6b9804b64ef79c328dd6839b1bc2ef762b275',
     armv7l: '0023e30b23e00619fdfef8d497d6b9804b64ef79c328dd6839b1bc2ef762b275',
       i686: 'ec6dedcabe255f6ae1b476002bf072fb01b04503d133da6a76978fed386e3e8b',
     x86_64: 'ff3aaee614a276bcbde78d0afb4339ca7312b76e16f9811bb97a621cb6f8874c',
  })

  depends_on 'curl'
  depends_on 'hdf5'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
