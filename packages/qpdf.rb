require 'buildsystems/cmake'

class Qpdf < CMake
  description 'QPDF is a command-line program that does structural, content-preserving transformations on PDF files.'
  homepage 'https://qpdf.sourceforge.io/'
  version '12.4.2'
  license 'Apache-2.0 or Artistic-2'
  compatibility 'all'
  source_url 'https://github.com/qpdf/qpdf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '816a7f63f3d896884c66bb7abcbf1cd49bdf49e657e1c91b930aa0a880404c2d',
     armv7l: '816a7f63f3d896884c66bb7abcbf1cd49bdf49e657e1c91b930aa0a880404c2d',
       i686: '8851b26ddcf4fc1f0ec1b7f056705e57efbd6cd179a8616d29c277268a8ef0a7',
     x86_64: '507d9c8c455b9446ecf715882fc850dc5574f483432134bec69ef898c1a62f82'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnutls' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'openssl' => :library
  depends_on 'zlib' => :library
end
