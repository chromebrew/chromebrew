require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.386-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '294468ec8188d3ec9923a55b95b0333e137ca6073b27b3d43d82b238a658927c',
     armv7l: '294468ec8188d3ec9923a55b95b0333e137ca6073b27b3d43d82b238a658927c',
       i686: '188d6b4e071e819b11d6374e80603c5a3b5cb4528f32d526fa9262253b956fe0',
     x86_64: '8ce6a5d580af253abf7e485267275568024e5fdbc7767f9e24e60ef04f1fabad'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
