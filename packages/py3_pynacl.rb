require 'buildsystems/pip'

class Py3_pynacl < Pip
  description 'Python binding to the Networking and Cryptography (NaCl) library'
  homepage 'https://github.com/pyca/pynacl'
  version "1.5.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d9b614b5e30538b49a0d772d132f1cfddd48c5be4b82b4928abef30b1f452b5',
     armv7l: '8d9b614b5e30538b49a0d772d132f1cfddd48c5be4b82b4928abef30b1f452b5',
       i686: '1441c935e734cb56c0762ee306395910e126ddb6404df7167fa50142da7db1cf',
     x86_64: 'e8bc20f388b43b4ebe64dbf1777aef7de012fcca16b823a97bae5b51a64f0814'
  })

  depends_on 'libsodium'
  depends_on 'python3'
  depends_on 'glibc' # R

  no_source_build
end
