require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.403-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd96987c16f638c5c6cbfa91f2477aaafcc8dec6ebcc126547bf28bd5a288acb',
     armv7l: 'cd96987c16f638c5c6cbfa91f2477aaafcc8dec6ebcc126547bf28bd5a288acb',
       i686: '3084c63a533c58c9ed20bccf0fce1c233d5bdc889f93686015d6369fef832d12',
     x86_64: '0ac56e402c4f03da37d55b65de7d434829f3717b1e3ef5fe4055e1b3d18442e5'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
