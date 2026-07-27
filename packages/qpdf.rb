require 'buildsystems/cmake'

class Qpdf < CMake
  description 'QPDF is a command-line program that does structural, content-preserving transformations on PDF files.'
  homepage 'https://qpdf.sourceforge.io/'
  version '12.3.2'
  license 'Apache-2.0 or Artistic-2'
  compatibility 'all'
  source_url 'https://github.com/qpdf/qpdf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53a790ba153b2533d9384f3653830942fd87eac4f5f58b58d161a32af06d012c',
     armv7l: '53a790ba153b2533d9384f3653830942fd87eac4f5f58b58d161a32af06d012c',
       i686: 'd71562f7c38ea4a57274fc8d6d8a85bbc91feb19af8ffc1417f9a183d5b2dba6',
     x86_64: '36dde4a77f5bbad284e02f9ca7d684a36d6b03c97addfe7a7667711feb5fdecd'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'gnutls' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'openssl' => :library
  depends_on 'zlib' => :library
end
