require 'buildsystems/pip'

class Py3_parameterized < Pip
  description 'Parameterized testing with any Python test framework'
  homepage 'https://github.com/wolever/parameterized'
  version "0.9.0-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46f2f76a4b9c4de61dc5ef66c2cfa3d43063e800a3d8099bd643ed9a7a131128',
     armv7l: '46f2f76a4b9c4de61dc5ef66c2cfa3d43063e800a3d8099bd643ed9a7a131128',
       i686: 'cd7d5805764cbe43edc69d97b5b5144f4ea060b69f0079b8f3c7a7ab889a9cb5',
     x86_64: 'a077ae09edf26938db82d660762e9c86c73f46e6c70cd2632983ec858406a80d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
