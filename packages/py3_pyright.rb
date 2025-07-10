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
       i686: 'd3c265d32182fc6eb739f0d0b23fd3af38b3a342594ddc0ad6446cfb029e30dc',
     x86_64: 'fbe9d58fd596105f3b058d90b13e92b2b403a1660ff3e9ecfd04456312740a19'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
