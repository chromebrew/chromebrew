require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.27-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '35b9ec6c4fb6bb7ba9113316a6fb34d032385b501856a1e9ec932bade74812af',
     armv7l: '35b9ec6c4fb6bb7ba9113316a6fb34d032385b501856a1e9ec932bade74812af',
       i686: 'abad035be6969e9191d6e214139f90ac93f470d3ca9b4683f0e595be19c8f65d',
     x86_64: 'd864876c5442d8d94ed449a69fe234827812402d8c2b8cfecad21d53654350f6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
