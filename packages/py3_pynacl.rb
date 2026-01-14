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
    aarch64: 'afba8591fab8133eb7813d834c466ac399fe4757d4a646d411103041c90af079',
     armv7l: 'afba8591fab8133eb7813d834c466ac399fe4757d4a646d411103041c90af079',
       i686: '75efad52833e54dca8f849f05ff5643d91828cf85c6457c83297a0940d66f7be',
     x86_64: '54138afd06f9d2470adc5fcb6eb41a3107e069a6faa7c6300be8c66fc11f5e5c'
  })

  depends_on 'glibc' # R
  depends_on 'libsodium'
  depends_on 'python3'
  depends_on 'python3' # R

  no_source_build
end
