require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.394-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55ac2e90ca7b0e16001dfd459bb3ffa07afe1a890d3aee6eb8ddd93ce1bb3b30',
     armv7l: '55ac2e90ca7b0e16001dfd459bb3ffa07afe1a890d3aee6eb8ddd93ce1bb3b30',
       i686: '3a167db83fe57059a63230ae9b6bb5c07b5c7c5936adabd469e59f532deb78cd',
     x86_64: '3398140920e6e74a53bc3f6c70139aff698d9125b74d7b80d3075a9540c7147a'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
