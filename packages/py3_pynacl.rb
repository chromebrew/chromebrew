require 'buildsystems/pip'

class Py3_pynacl < Pip
  description 'Python binding to the Networking and Cryptography (NaCl) library'
  homepage 'https://github.com/pyca/pynacl'
  version "1.6.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c66b7b092003a3794ab3dc7edbbede791d555267d54efc5debd7a26ffb4fdf4b',
     armv7l: 'c66b7b092003a3794ab3dc7edbbede791d555267d54efc5debd7a26ffb4fdf4b',
       i686: 'cb142ff0657183b3dfa982a3263b6f828377b853f986b662b94cc4f77e0d7b81',
     x86_64: '28ab18a529270c75402ecd42bc8ff7603b99bae5606010d8f40068032278ec6b'
  })

  depends_on 'glibc' # R
  depends_on 'libsodium'
  depends_on 'python3'
  depends_on 'python3' # R

  no_source_build
end
