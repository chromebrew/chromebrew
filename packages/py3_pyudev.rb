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
    aarch64: '8112703e71b45b29695dc7e6022f11ceaa3f97a6651b6810e892e9a7a908750e',
     armv7l: '8112703e71b45b29695dc7e6022f11ceaa3f97a6651b6810e892e9a7a908750e',
       i686: '030936d9e515b16072bd078afa022f80c9a7590363b3449c67e3e7421657be65',
     x86_64: 'e417b020e5819bb2b9b8379f691b7a196ae2f036aca461f13f784c0d1873159d'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
