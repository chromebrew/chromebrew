require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.408-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aeab0df511cef0cf10557967a22d61f2d59052dd82d0ff2542e47d0674d264ba',
     armv7l: 'aeab0df511cef0cf10557967a22d61f2d59052dd82d0ff2542e47d0674d264ba',
       i686: '4699fab0f8c4bc4e2d117bd7e3ca939380b878d4c1e535efe40fac1d68682606',
     x86_64: 'e866b2c0f822b155bf93eb09f0921b9c9a74157d8519e764ab12a421eb91133c'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
