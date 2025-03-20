require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.397-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c3848510909f6a70868f8e2cddc63a69ae5cfe182730d1ce347a88188fdc06c',
     armv7l: '6c3848510909f6a70868f8e2cddc63a69ae5cfe182730d1ce347a88188fdc06c',
       i686: '021086225256b9c5bf54733623329e3ff5b7f886521ca8a7de568667c3eef531',
     x86_64: '4877e12ae66173fa8d297de59e9ad9c05716f42b3f23b6f3b4431909691b4cd9'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
