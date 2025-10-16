require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "46.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5f8245beb79b84ad3876f857654ceb16706a44d816b8df923f1dac58c97947d',
     armv7l: 'a5f8245beb79b84ad3876f857654ceb16706a44d816b8df923f1dac58c97947d',
       i686: 'e7c95f240a19b11f81895a3eac8a99d016fe2c4bbab7e54332aacb476c223672',
     x86_64: '91ee275ac669fc95a62409d41f451cd1ceb1cd64cdd3df0a43504dc088e8819f'
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
