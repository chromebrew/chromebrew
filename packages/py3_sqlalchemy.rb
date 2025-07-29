require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.42-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6960aa31308551106dd86c28908ce841440ddc49a330527d6fb4a8d32ab9552d',
     armv7l: '6960aa31308551106dd86c28908ce841440ddc49a330527d6fb4a8d32ab9552d',
       i686: 'cc200fc68b6e9b27db6ee62469514fe00097b824c11735e720109b4309826803',
     x86_64: '3a1abe9a956bc99d22efed641b23fe404c4b78aaea64237b503a2f608cc3816c'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  no_source_build
end
