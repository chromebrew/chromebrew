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
       i686: 'b098d69615f90154858015e91fe081ec9d0d36e1ce1b1062d596333e75323581',
     x86_64: '2881f3b81b55b1d6b45078d1879c7bf22a367f269d5041cfc57041bef13c8734'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
