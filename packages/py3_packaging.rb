require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version "26.0-#{CREW_PY_VER}"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa9b242032dd84a55a9063efefd981e84dd748cd5433a202863b1b0cda891b28',
     armv7l: 'fa9b242032dd84a55a9063efefd981e84dd748cd5433a202863b1b0cda891b28',
       i686: '609a4a7d98cbe9c8e60895c1a87f8183621ad0f3fba3c4c356c16a307ce428fd',
     x86_64: '67e263f1915497b6909806004ecce887b00aec3d3a63f34f8e7252d5cc8bd080'
  })

  depends_on 'py3_pyparsing'
  depends_on 'python3'

  no_source_build
end
