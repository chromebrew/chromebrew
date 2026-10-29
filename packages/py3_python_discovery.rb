require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.6.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d4d3533c74a1ee8d8d7a8880b3539a515cec0590449535899aba96c0c59341f',
     armv7l: '9d4d3533c74a1ee8d8d7a8880b3539a515cec0590449535899aba96c0c59341f',
       i686: '88ed44dea90e1004e3afa600b7559b7d9f0c5e4b72968d7305e2365c3d89e518',
     x86_64: '72417446838c10311ffaaa6cadd549b9f2f11c03d435af78763376ada4736710'
  })

  depends_on 'python3' => :logical

  no_source_build
end
