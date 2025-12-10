require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.45-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '81c08f636346a6c1ae575a3c727cb218b7b40b21f5cf8dd612efd7045ff45f0c',
     armv7l: '81c08f636346a6c1ae575a3c727cb218b7b40b21f5cf8dd612efd7045ff45f0c',
       i686: 'c0cb725faabcd6d405030e827bbf341e42dcbdd4dcc88710a9f116287a1a6c91',
     x86_64: 'b64153400c0fca6b541321fa6278a8c42fe78abe2a15432c52c1b214b55fab6e'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
