require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "45.0.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9085a3050a6f67b9d01686a5642b76ab57b0eb42cbb7b1ac4e6a864683578845',
     armv7l: '9085a3050a6f67b9d01686a5642b76ab57b0eb42cbb7b1ac4e6a864683578845',
       i686: 'ec51a8dc9b45135bf6bf442205750e6e7e4eeefdc8b5f1341163fd9265c1cf2e',
     x86_64: '44bc9a72abf9c119cac7ac2b7299bd8b110f42ca53f5a5f7b8927755225e5895'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'rust' => :build

  no_source_build
end
