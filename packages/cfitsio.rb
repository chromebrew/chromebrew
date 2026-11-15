require 'buildsystems/cmake'

class Cfitsio < CMake
  description 'A library of C and Fortran subroutines for reading and writing data files in FITS Flexible Image Transport System data format'
  homepage 'https://heasarc.gsfc.nasa.gov/fitsio/'
  version '4.7.0'
  license 'ISC'
  compatibility 'all'
  source_url "https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-#{version}.tar.gz"
  source_sha256 'ce573bbea8e75b429f8c3d3e86498741ba3dc9628a1530d2f65268397ad059e8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e051753c055e2001d5aeae352112733baefaec34f061fb23824de7d48a99ac15',
     armv7l: 'e051753c055e2001d5aeae352112733baefaec34f061fb23824de7d48a99ac15',
       i686: '59bc10402139767648483cfbd56f03d665c1975cb2ef9025eb93e5a8c5b4e250',
     x86_64: 'ebc0566727ae013cecb4d1ef2aa24982b4c815a23d4b8c3d4b8309276d428100'
  })

  depends_on 'curl' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library
end
