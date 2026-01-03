require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.33.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'de9c1e0cf2f6a54d2909aad26277172111794180023a6ad599a6e0c26eef3e3c',
     armv7l: 'de9c1e0cf2f6a54d2909aad26277172111794180023a6ad599a6e0c26eef3e3c',
       i686: '62ab0904db32be0d9b618ebb3b63ac688a45d979226a62338bc6365fc4f972db',
     x86_64: 'b35ab2c8f7d511f7552153d8749b525dde2611186e239a36fef2879774c9c606'
  })

  depends_on 'py3_py'
  depends_on 'py3_filelock'
  depends_on 'py3_six'
  depends_on 'py3_packaging'
  depends_on 'py3_virtualenv'
  depends_on 'py3_pluggy'
  depends_on 'py3_toml'
  depends_on 'python3' => :build

  no_source_build
end
