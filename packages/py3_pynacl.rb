require 'buildsystems/pip'

class Py3_pynacl < Pip
  description 'Python binding to the Networking and Cryptography (NaCl) library'
  homepage 'https://github.com/pyca/pynacl'
  version "1.6.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c22806284adfbbfc639ca1ab1f18a0d4dae7bcd074d456c8d97f4e9fec8706c5',
     armv7l: 'c22806284adfbbfc639ca1ab1f18a0d4dae7bcd074d456c8d97f4e9fec8706c5',
       i686: 'f874cf11499ed8c5729d85997cfe8c2b0d456a466dfb97e49b215a3bac7ab902',
     x86_64: 'bfac5d352c1e0adf5e28b743c2ab1170b3e7cae6e8742f7643f1961ca158b226'
  })

  depends_on 'glibc' # R
  depends_on 'libsodium'
  depends_on 'python3'
  depends_on 'python3' # R

  no_source_build
end
