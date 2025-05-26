require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "45.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7728f431a303989a47a7c226535ae7df519919bd123f825bc9560b992404eda2',
     armv7l: '7728f431a303989a47a7c226535ae7df519919bd123f825bc9560b992404eda2',
       i686: '4cfad85b5fc2e96529a613a32cc62fcbd0d364b936932cc6b04ea2e17ca2099e',
     x86_64: '096165f4753099d0e36a8870df227f911ff82cdbc406291735cbc0cd085e9634'
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
