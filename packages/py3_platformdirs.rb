require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.10.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2cd466bac068b3c10c7c07b8d045262e3285a3dac76cb6e3ca75f8e2a9af8d52',
     armv7l: '2cd466bac068b3c10c7c07b8d045262e3285a3dac76cb6e3ca75f8e2a9af8d52',
       i686: '433f9d219db30805827b73c3759cf3fa4382c599a5709dc09f85ba1aeec81403',
     x86_64: 'bb16cd4f1812f0acc1cbc43694a038c0bc4c759c8bd9291562e5a5071570ce7e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
