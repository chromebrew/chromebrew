require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.391-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e2e125471611ebac7d9edbef7d0052d217fc8afa4beb7490ff633727b807770',
     armv7l: '7e2e125471611ebac7d9edbef7d0052d217fc8afa4beb7490ff633727b807770',
       i686: 'c2c372e17c332d2ca6c8e817fcf87686537f3bde28e090bc48ada3b08f80ee2c',
     x86_64: '870b447e20404b11178d42807a77fc1a0aaea738b0b9fb90eba7219b42fad175'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
