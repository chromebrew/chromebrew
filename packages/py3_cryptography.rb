require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "45.0.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3a3ddfbfaaaeb057a386d303eac9ffbf4288b747e26201e5b33b2e286224844',
     armv7l: 'd3a3ddfbfaaaeb057a386d303eac9ffbf4288b747e26201e5b33b2e286224844',
       i686: '4b8cdfac335359d0dfcf42ca29ecd1acce87a94c9ca8cc38c501c54f7d1bfc79',
     x86_64: '5a07fe0fb1e7bc85a1b89a183821e01a92c122940e8816f985a6e94e9e275c4e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'rust' => :build

  no_source_build
end
