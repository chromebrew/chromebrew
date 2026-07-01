require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.38-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '860f6daec3512270ed4c5f5ecf9c49ff60c8c02b448cd286f0ea58f808911584',
     armv7l: '860f6daec3512270ed4c5f5ecf9c49ff60c8c02b448cd286f0ea58f808911584',
       i686: 'f8d572ac1c6732ec0812dde079f548a65717ac790a4216ab68b475e226e25a7a',
     x86_64: 'c868e9bc40e7c88a549dd52990a41aaed7b5dd55e2ce162939e6e2a611f25703'
  })

  depends_on 'python3' => :logical

  no_source_build
end
