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
    aarch64: 'da9a51e11e8987d8a32ea2a17c8cbd0bd7b56b91e46162f1f737650e26a93076',
     armv7l: 'da9a51e11e8987d8a32ea2a17c8cbd0bd7b56b91e46162f1f737650e26a93076',
       i686: 'fbd9c38a0a9873ec9806e5b9526ec062e58aa489c37cd4f3e508e28aa05f9de4',
     x86_64: '5da93c84290f8693de429ec83a33b09b3f1cf0e3ac6a048df2ad7a23d9b67467'
  })

  depends_on 'python3' => :logical

  no_source_build
end
