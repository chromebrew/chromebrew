require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.64-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf65fef15a495fd99a939946fef27eaecd064c37d13b877acd0728403e8d2a7d',
     armv7l: 'bf65fef15a495fd99a939946fef27eaecd064c37d13b877acd0728403e8d2a7d',
       i686: 'f93ea1187d59ffd8487d745955917c4e5379c48c6556d2b424b3a75fcc6db6f9',
     x86_64: '79e51e29c01d6f4397bbb6100fcc5f0d2179bb50435db6e4546756befcfa5543'
  })

  depends_on 'python3' => :logical

  no_source_build
end
