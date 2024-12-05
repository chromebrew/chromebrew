require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.390-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '514da85d623010e143697f87cbebc3d7e7283f8df61a01bdda80cea6c3cf5e1f',
     armv7l: '514da85d623010e143697f87cbebc3d7e7283f8df61a01bdda80cea6c3cf5e1f',
       i686: '41e35b1b836ffd4c7209cecd1c74db4b0430015aa479f04d60839061a62cd080',
     x86_64: '6e045f72f979df2a52627d1be1dfb3c62d011202d87b168f604b1c39e87b7ea2'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
