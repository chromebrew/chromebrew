require 'buildsystems/autotools'

class Fftw < Autotools
  description 'FFTW is a C subroutine library for computing the discrete Fourier transform (DFT) in one or more dimensions, of arbitrary input size, and of both real and complex data (as well as of even/odd data, i.e. the discrete cosine/sine transforms or DCT/DST).'
  homepage 'https://www.fftw.org/'
  version '3.3.10'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://fftw.org/fftw-#{version}.tar.gz"
  source_sha256 '56c932549852cddcfafdab3820b0200c7742675be92179e59e6215b340e26467'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '104ed5989de12cd2edddc03978cd1cba48e503d50eba8f4de5e63d5e44c3ec92',
     armv7l: '104ed5989de12cd2edddc03978cd1cba48e503d50eba8f4de5e63d5e44c3ec92',
       i686: '8bb8ff951cf62a5f339b37cdadd21836ee6499a054eceb7c7acfa19f4789896d',
     x86_64: '3de2966c788cbd46d2c74cf010f781337651b5f7086d7b0b9c5117e131025819'
  })

  # We'd need to build fftw three times with each precision option in order to support things properly.
  # https://www.linuxfromscratch.org/blfs/view/cvs/general/fftw.html
  # https://github.com/FFTW/fftw3/pull/276
  autotools_configure_options '--enable-shared'
  run_tests
end
