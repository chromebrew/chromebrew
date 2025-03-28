require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.40-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3da3e235cc3e21152cb9e4a6e8b092dc54c3d723f606ca8d2db2a4e53764b1a',
     armv7l: 'e3da3e235cc3e21152cb9e4a6e8b092dc54c3d723f606ca8d2db2a4e53764b1a',
       i686: '3db0f4b4681efcad09d9af1be7ef3a1f5d0a48fc0852e2358a3b7af2e170355c',
     x86_64: 'f058221ab86b7cd8c51f98f9f6056c294adf4d113a627dcf0c0a6e5c5b7bf5b6'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  no_source_build
end
