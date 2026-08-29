require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "9.0.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59cf79367ea582b01a95ab5ba60f465d894d63a1878a193608056b705b4eeb83',
     armv7l: '59cf79367ea582b01a95ab5ba60f465d894d63a1878a193608056b705b4eeb83',
       i686: '0b4b221a6d6f11074ef54f779f6912947bda4f5e2735faf6f8942edc47930156',
     x86_64: '927ef73350249c79b1c46086c10c10ac5f51daab922aaa7e34d761f964466fd5'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :logical

  no_source_build
end
