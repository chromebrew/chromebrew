require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.89-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3835810a38d85396df791159dbbcf0bbda985ac3c024af207089f772896b176',
     armv7l: 'a3835810a38d85396df791159dbbcf0bbda985ac3c024af207089f772896b176',
       i686: '6d2d4bf30a61a6420a0be87c7e10e032510de9ee88747ead282fefc4a2716221',
     x86_64: 'ce4070200d0e35fd1a7d02e6732f3bfe7b4b9d50a81578075b90123d5b4d21e9'
  })

  depends_on 'python3' => :logical

  no_source_build
end
