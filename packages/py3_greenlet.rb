require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.5.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9856d9efef75cc48d82046c8703193223d9963bf7a0255400843659080513c6c',
     armv7l: '9856d9efef75cc48d82046c8703193223d9963bf7a0255400843659080513c6c',
       i686: 'ab25ea9cf6b6d9baf745680b6717f0b73343d9c6b327baf80a272ab6621a3c3f',
     x86_64: '205218d946298c4687ec6d482b5a1c2028f848afc5740226704b97e69b86a6c5'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :logical

  no_source_build
end
