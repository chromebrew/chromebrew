require 'buildsystems/pip'

class Py3_pyudev < Pip
  description 'Pyudev provides Python bindings for udev.'
  homepage 'https://pyudev.readthedocs.io/'
  version "0.24.4-#{CREW_PY_VER}"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a2841ff829df356ec6d248bae77bc94ad0d9bf9a06e6cd984cf168d2fb57b02',
     armv7l: '5a2841ff829df356ec6d248bae77bc94ad0d9bf9a06e6cd984cf168d2fb57b02',
       i686: '0470c068b9e685a8ec9f67041eb83200b092d4368ec1f816a432d43653d4fa11',
     x86_64: '2227eadbc14f42962f388f0fd1cb298619514b69e31ff3ad7a9b3f1ba524f31d'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
