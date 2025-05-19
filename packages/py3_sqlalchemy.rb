require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.41-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18111a99ce4351a56d5fe0ab4e9513faf3337d6ab8b5d00515f3368f75898de4',
     armv7l: '18111a99ce4351a56d5fe0ab4e9513faf3337d6ab8b5d00515f3368f75898de4',
       i686: 'cc200fc68b6e9b27db6ee62469514fe00097b824c11735e720109b4309826803',
     x86_64: '3a1abe9a956bc99d22efed641b23fe404c4b78aaea64237b503a2f608cc3816c'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  no_source_build
end
