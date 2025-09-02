require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "45.0.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0a2da7a89e67d61dd61c530facfd317dfda3e0c45e7bd21955803ec4d937134',
     armv7l: 'b0a2da7a89e67d61dd61c530facfd317dfda3e0c45e7bd21955803ec4d937134',
       i686: '03d33eea5037311bbb1deabe04f9401b0815006c3f90a710bd68cea6978f179e',
     x86_64: '4d3ce78a8ff95269857fb66304697b256c342d818ab8f1ca356e515da80ff386'
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
