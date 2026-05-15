require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '37dce3e6027ca8ddb30dee1c7b93550943f23fbc8c30f33e7eda13c68fd8b463',
     armv7l: '37dce3e6027ca8ddb30dee1c7b93550943f23fbc8c30f33e7eda13c68fd8b463',
       i686: '11e06e0b62da047cc8a16fe4c93c55506cc2c0e853cf22189e8e88ba2fced047',
     x86_64: '05344dabaf4a3c345f1c5da1a723da09d13227b1053c49577d272f2d203c2656'
  })

  depends_on 'python3' => :logical

  no_source_build
end
