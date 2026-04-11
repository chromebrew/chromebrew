require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.4.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '338963ab7e5ddaae2ec6f50af125cb7456ab342d51351ba7b8e796f8df0b0f73',
     armv7l: '338963ab7e5ddaae2ec6f50af125cb7456ab342d51351ba7b8e796f8df0b0f73',
       i686: 'fb6774cf368ef673f24f7477ba0636bbe3b3704500329cafc051750c7d7651ae',
     x86_64: '68ffe4b6a62a55f7a92d8324531de8392355332145b75d696a6795b5ec61da2b'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
