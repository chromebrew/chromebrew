require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.84-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bba198a9a2ba5168526d768288a284c22c0339be1312a28cfa0e18f2d9e21640',
     armv7l: 'bba198a9a2ba5168526d768288a284c22c0339be1312a28cfa0e18f2d9e21640',
       i686: '893e5613c05fbc4131b35880984d019ce00cc5cc784b8e3f87b370c68de41d75',
     x86_64: '093dd2e66e336464d3c73e23a6c0aef534b26ee58858420ea0b5aa23d38fd047'
  })

  depends_on 'python3' => :logical

  no_source_build
end
