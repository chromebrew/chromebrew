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
    aarch64: '514da85d623010e143697f87cbebc3d7e7283f8df61a01bdda80cea6c3cf5e1f',
     armv7l: '514da85d623010e143697f87cbebc3d7e7283f8df61a01bdda80cea6c3cf5e1f',
       i686: 'c2c372e17c332d2ca6c8e817fcf87686537f3bde28e090bc48ada3b08f80ee2c',
     x86_64: '870b447e20404b11178d42807a77fc1a0aaea738b0b9fb90eba7219b42fad175'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
