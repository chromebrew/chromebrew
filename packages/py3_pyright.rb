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
    aarch64: '6551a6298f924244a61bc6d4329fbd238e4244e53ea25049608764cc27b95a09',
     armv7l: '6551a6298f924244a61bc6d4329fbd238e4244e53ea25049608764cc27b95a09',
       i686: '41e35b1b836ffd4c7209cecd1c74db4b0430015aa479f04d60839061a62cd080',
     x86_64: '1fb5588d3a90397b343cdb0fcfe8830d4c56c5b9455974582ab3f07b261d2dfc'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
