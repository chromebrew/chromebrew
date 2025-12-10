require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "8.7.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a1e2b9f522e1a391ff0bba0501c2d3ccf5056a5869fc846dae6050a4fedae316',
     armv7l: 'a1e2b9f522e1a391ff0bba0501c2d3ccf5056a5869fc846dae6050a4fedae316',
       i686: '921d8a387bd2bf1c66de0acd079af11c1e9592bbde47de9edc860a0e47cd5028',
     x86_64: 'ebf86f4a9262ce948d9febddcd3c17c4ada759b9fa91ae829bc29e3b21d6c43a'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :build

  no_source_build
end
