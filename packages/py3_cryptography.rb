require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "47.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '04d60d2a669a96b55cd44c58430c74bb32d78451308590bfcbd77456520ad6b9',
     armv7l: '04d60d2a669a96b55cd44c58430c74bb32d78451308590bfcbd77456520ad6b9',
       i686: '00bdff2601a7ddaedccdf3edbe54f97ecff19dbdd098210f93703dcd64a357b8',
     x86_64: '513007e6d3f8749b5b2faf3d3a539f10c407534cfb9716efb8a0367f08eef548'
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
