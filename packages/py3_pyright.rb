require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.383-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b8a3b750397f04a2d60bbb466bfce22624ab891579cd978955cd83c68262fb1d',
     armv7l: 'b8a3b750397f04a2d60bbb466bfce22624ab891579cd978955cd83c68262fb1d',
       i686: 'e3ded8f11899384fc4b7ba77d59c70e0629409a41b810eaa0d3bf1412b615c09',
     x86_64: '0a8f55a913a858c190b8a97f5cb24fc144bed4cc0ba542b5e2c3e3c0f367df38'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
