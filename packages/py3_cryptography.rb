require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "46.0.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f01dd6b55f4865da186bad9c9561ae22335821bc5da8f49524970ac4bf22b89a',
     armv7l: 'f01dd6b55f4865da186bad9c9561ae22335821bc5da8f49524970ac4bf22b89a',
       i686: 'e5f18fbeb01efc2874ea6f7e43f563a96d0263646940570f469d9b56cae3625d',
     x86_64: 'bb4bd331218d130efbd68808cee568aa42d043bb12696b7fdac9d89a0038033f'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'openssl' => :library
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
