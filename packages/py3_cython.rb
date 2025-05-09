require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.1.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'acd83f7579b329c9cbf47e552b3ac54bdf3267c2714b04dca41a54f6bb37cbfc',
     armv7l: 'acd83f7579b329c9cbf47e552b3ac54bdf3267c2714b04dca41a54f6bb37cbfc',
       i686: '6602c5896e4c67a585fc03454d42f1da6c74987e1bce223ba28e4a5f984a8622',
     x86_64: '8676b0725b75eeae72927a03bf10f678cf3ac3c9024e27d532e4578608a00f20'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
