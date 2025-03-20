require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.397-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f68247de198d5f6f95e214b9b546283cc1765fb0b8099b88e1afb5670fa79eb7',
     armv7l: 'f68247de198d5f6f95e214b9b546283cc1765fb0b8099b88e1afb5670fa79eb7',
       i686: '021086225256b9c5bf54733623329e3ff5b7f886521ca8a7de568667c3eef531',
     x86_64: '9e4db30ba4f5b55f0cb42d4f9f1e696a003d89fe70c8d776a31761831bf256bc'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
