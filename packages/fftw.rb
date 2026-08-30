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
    aarch64: '7c12af0ee15819d3c4cd87e09c86f33587250bd1ba791e10ab1dfd6ec2ecb76d',
     armv7l: '7c12af0ee15819d3c4cd87e09c86f33587250bd1ba791e10ab1dfd6ec2ecb76d',
       i686: 'a2e3de9475c9b8e91088b80a4f8c65cd89c24530dfd94a46f2514a76c51a850f',
     x86_64: '6530ec2a959bb3de0f15ebf96c3b2cf9d93853d2bd4a01769d78e559ce7c7887'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  # We'd need to build fftw three times with each precision option in order to support things properly.
  # https://www.linuxfromscratch.org/blfs/view/cvs/general/fftw.html
  # https://github.com/FFTW/fftw3/pull/276
  autotools_configure_options '--enable-shared --enable-threads'
  run_tests
end
