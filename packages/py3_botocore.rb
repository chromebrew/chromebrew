require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.42-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '15f97d67b7b673b1be09960c6a7bf49c0e3fa80a4e4869007e4b121c1723be68',
     armv7l: '15f97d67b7b673b1be09960c6a7bf49c0e3fa80a4e4869007e4b121c1723be68',
       i686: '0db03884c77803e2fa6e9dae624a8c26d56fe0c3b1f154c11094510853e3a2c0',
     x86_64: 'd29b67e56af34d7cc946ba07e633a4f1c03819bad6d9fd3a17f2e73bf28a9cce'
  })

  depends_on 'python3' => :logical

  no_source_build
end
