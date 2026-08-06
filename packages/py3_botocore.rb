require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.65-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd18f60fa74106a953e904da22adfceb0c53882e07e542dba23694c55924c0f0c',
     armv7l: 'd18f60fa74106a953e904da22adfceb0c53882e07e542dba23694c55924c0f0c',
       i686: 'fa58c27452d9c4977b56b8946b3ddba05af240bea98d9523231366ff180a2c13',
     x86_64: '594f733e209ac5ccd678b1b002d39a4125489392712978b4b7612976ce7c8820'
  })

  depends_on 'python3' => :logical

  no_source_build
end
