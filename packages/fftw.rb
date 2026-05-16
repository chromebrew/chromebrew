require 'buildsystems/autotools'

class Fftw < Autotools
  description 'FFTW is a C subroutine library for computing the discrete Fourier transform (DFT) in one or more dimensions, of arbitrary input size, and of both real and complex data (as well as of even/odd data, i.e. the discrete cosine/sine transforms or DCT/DST).'
  homepage 'https://www.fftw.org/'
  version '3.3.11'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://fftw.org/fftw-#{version}.tar.gz"
  source_sha256 '5630c24cdeb33b131612f7eb4b1a9934234754f9f388ff8617458d0be6f239a1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '967ee876b47a3f0a8354fa5587a9cd6103cd6629a908ded148b69634cef47839',
     armv7l: '967ee876b47a3f0a8354fa5587a9cd6103cd6629a908ded148b69634cef47839',
       i686: '8ef033f81a7398024a7a757187bb5e259562d472752e7680746afd1cbb692ebc',
     x86_64: '27e304bd4022d580dbc181e5f08f250179c80cd2c109639dd7e2ab619fc4e136'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  # We'd need to build fftw three times with each precision option in order to support things properly.
  # https://www.linuxfromscratch.org/blfs/view/cvs/general/fftw.html
  # https://github.com/FFTW/fftw3/pull/276
  autotools_configure_options '--enable-shared'
  run_tests
end
