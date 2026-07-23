require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.5.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3933e7f552fa9d4f4d2c07cd450a0ecfafdc983d515b5cf47bac786a50c7ed3',
     armv7l: 'a3933e7f552fa9d4f4d2c07cd450a0ecfafdc983d515b5cf47bac786a50c7ed3',
       i686: '5fbf4df0c8461370fbdd25a2521db009948c435dc3f1a909b56a0fc464043de1',
     x86_64: '5d9d810f9c3c69c6b7274bdcf190833b2bc81a7ae0793169bc53b7a1b934878c'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :logical

  no_source_build
end
