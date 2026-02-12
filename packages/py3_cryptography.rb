require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "46.0.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6edb999a66cc100d2c442783bfd08778d89c47078617d1e595c3508333554989',
     armv7l: '6edb999a66cc100d2c442783bfd08778d89c47078617d1e595c3508333554989',
       i686: 'fce33270aa206d049a8a306b4a5f66b7fefaf71cacfa67a1a862d70ad13d79c2',
     x86_64: 'bc49e3993e4b1e77204dc7efc0dbfb5212043222ed696f04d4702e282a1efec0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
