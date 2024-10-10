require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.2.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c90ea4b299f44833063dc8db66437f494ff2e4a31f0ce337edbc714270c7447c',
     armv7l: 'c90ea4b299f44833063dc8db66437f494ff2e4a31f0ce337edbc714270c7447c',
       i686: '6b8ad1b4db373039dc2e1d2c0b39b9e0d991f0d95614d95b6ddcf86d9a2e15cc',
     x86_64: '659e70fa8eb4c4be7c09958a0212bc141a6e4e0c81c3cdd1e1fb844a1301025b'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'

  no_source_build
end
