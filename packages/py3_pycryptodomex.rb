require 'buildsystems/pip'

class Py3_pycryptodomex < Pip
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.23.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '75a07d9154be8e79fba3465334979115b862f861829aa463b4fd66c79b612b75',
     armv7l: '75a07d9154be8e79fba3465334979115b862f861829aa463b4fd66c79b612b75',
       i686: 'abaa9df2dc84d09f1783cb0598cb30723406d1c2502682bea9593e7f5cbf0d86',
     x86_64: '816ccf0dc105f352ba35c05c319a23a36d5ce5a127f2595b21c40fd16c7b0ac1'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  no_source_build
end
