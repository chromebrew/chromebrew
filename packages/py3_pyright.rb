require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.388-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2a8288f97b5e48e2186ac9518fefda6dd42f37c53ad2d960054a1c3a3434e2f',
     armv7l: 'f2a8288f97b5e48e2186ac9518fefda6dd42f37c53ad2d960054a1c3a3434e2f',
       i686: '1e7555c57c6cb790e72cf3d4f24cf4f1896e9519d3d72ca05944801f9be753eb',
     x86_64: 'fd09a0a55fe60b18fb28621b151535138813516525dd6d908d4bbfa0a30f0791'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
