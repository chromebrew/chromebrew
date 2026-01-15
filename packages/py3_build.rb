require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c9b4ff8686b3bcf76aef2f370b050baebafee31d9037dd5bbf8ff760ef3c921',
     armv7l: '6c9b4ff8686b3bcf76aef2f370b050baebafee31d9037dd5bbf8ff760ef3c921',
       i686: '9a2e7ff456f931e9b6470374d08fa38a66a1b4c55dd395172b7adef40f97320e',
     x86_64: '2c7f9db2ee99fbc75be35d3a8b590adde8626ba71a8609935c011634859d800a'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'

  no_source_build
end
