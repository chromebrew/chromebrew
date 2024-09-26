require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.20.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e8078a84a5689fb5053b2cbde1775feea01e349bd2f3578ea1995cf5afd38e84',
     armv7l: 'e8078a84a5689fb5053b2cbde1775feea01e349bd2f3578ea1995cf5afd38e84',
       i686: '0055e376118e2831314951232f39de4af3a8d9846dd55d0c374ce16083f95b5f',
     x86_64: '6a361c42491d40c05485c8a03a94ffc43a0a35b074e9e4aba273e15fe3f754e9'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
