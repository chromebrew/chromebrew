require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.404-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aef00fa30722513ce417c37dd71770b7653eb30933d0d7aca0aa5c50bde86792',
     armv7l: 'aef00fa30722513ce417c37dd71770b7653eb30933d0d7aca0aa5c50bde86792',
       i686: '2d7ab69531d3da468171fc796e1bcb8e51fbcf01e128b36570801a0e3d734826',
     x86_64: 'bcca1a2e8bd9bbd712645cf72afb0c32416dcb4027d354095a37c640a87f80f7'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
