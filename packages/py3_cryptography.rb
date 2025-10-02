require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "46.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9529c90399ea70cef497f0decd811fe800b165ff690ccb2ad592cb65f0f695d3',
     armv7l: '9529c90399ea70cef497f0decd811fe800b165ff690ccb2ad592cb65f0f695d3',
       i686: '5d409e710c8d248a392b1520c1405d7a3d75f3e320e37789047cf6affb7b777a',
     x86_64: '1176b6b390ea5f8bbfc4047109dcfb53849d7315032894ed13fcda4ce9b765b7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
