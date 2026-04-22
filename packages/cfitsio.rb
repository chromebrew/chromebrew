require 'buildsystems/cmake'

class Cfitsio < CMake
  description 'A library of C and Fortran subroutines for reading and writing data files in FITS Flexible Image Transport System data format'
  homepage 'https://heasarc.gsfc.nasa.gov/fitsio/'
  version '4.6.3'
  license 'ISC'
  compatibility 'all'
  source_url "https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-#{version}.tar.gz"
  source_sha256 'fad44fff274fdda5ffcc0c0fff3bc3c596362722b9292fc8944db91187813600'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '893c4305e83b2257ccae7a7695a7816a4b6b66960eb6f43136e230002d3713cf',
     armv7l: '893c4305e83b2257ccae7a7695a7816a4b6b66960eb6f43136e230002d3713cf',
       i686: '60c458e9588a54b77128f2021d246415bfe6c72484bd45733f01bb492f9ca29f',
     x86_64: '2bf2f306ed51f38e1a544da2dc6bdae4b79538bec181bdc13e70e0cca8619bbe'
  })

  depends_on 'curl' => :library
  depends_on 'glibc' => :library
  depends_on 'zlib' => :library
end
