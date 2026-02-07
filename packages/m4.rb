require 'buildsystems/autotools'

class M4 < Autotools
  description 'GNU M4 is an implementation of the traditional Unix macro processor.'
  homepage 'https://www.gnu.org/software/m4/'
  version '1.4.21'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gnu/m4/m4-#{version.split('-').first}.tar.xz"
  source_sha256 '664f2b1654c363a6348b688d5d475ed9ec0e7ef3c72f6f315f37fe97a2fe63eb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aca57f77f399011bccaeaccd05136fac7d66ba713b72794ed00922808f9731b5',
     armv7l: 'aca57f77f399011bccaeaccd05136fac7d66ba713b72794ed00922808f9731b5',
       i686: '0b3dfd39dd009232673eb3277ac8762b4f4d1d156de74ba9691d30d7ceb18f5c',
     x86_64: '2761b53aa8ead691fc1762671000a5191af930663bd13282d9869e175acee917'
  })

  depends_on 'glibc' # R
  depends_on 'libsigsegv' => :build
end
