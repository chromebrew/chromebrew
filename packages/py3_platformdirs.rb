require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.12.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '93655dcf7adda3897f802982605c719b33190e998e9d5a4c81aaf7ec8ec4b9e8',
     armv7l: '93655dcf7adda3897f802982605c719b33190e998e9d5a4c81aaf7ec8ec4b9e8',
       i686: '564e4010e6632fcf150a19f908ec9cd173e34bed4723d9a79f6f44b27acda1a7',
     x86_64: '60ca11476ad0184dc28f8983d8b1fc231a5c8148200a274cabe82055fa4759cb'
  })

  depends_on 'python3' => :logical

  no_source_build
end
