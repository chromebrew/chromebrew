require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.14-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02193caa2444f93d025438be26e94320ea6bf32f32b5fe6ce3a5dbf0427824a1',
     armv7l: '02193caa2444f93d025438be26e94320ea6bf32f32b5fe6ce3a5dbf0427824a1',
       i686: '2b75b708709700fe8987f25dd031e56aacd0dbe72e0e7fa89bea667105b971e2',
     x86_64: 'd3e2e4b21b45188af93883c4de3f06c5157a121319f4c672844404e0a98bfab9'
  })

  depends_on 'python3' => :logical

  no_source_build
end
