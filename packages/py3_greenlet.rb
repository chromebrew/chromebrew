require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36fb060bd2b0dc869edc0936e8fd6a98c07abf68f0e52fe48497f83a6b721b98',
     armv7l: '36fb060bd2b0dc869edc0936e8fd6a98c07abf68f0e52fe48497f83a6b721b98',
       i686: '8037cae5f35d4f77b0865d753ff359d41d003f65f6e8650e41e617a8f868d981',
     x86_64: '323d9affe7a777d2bd24fcb63d41ad4f0363c351c61bb1c96a2001d910a918b9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
