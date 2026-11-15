require 'buildsystems/pip'

class Py3_pyudev < Pip
  description 'Pyudev provides Python bindings for udev.'
  homepage 'https://pyudev.readthedocs.io/'
  version "0.24.5-#{CREW_PY_VER}"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7628d9517df4728bc0efc3518f8c45eab1e52422cb4ccef0fc733565775c370',
     armv7l: 'b7628d9517df4728bc0efc3518f8c45eab1e52422cb4ccef0fc733565775c370',
       i686: '419816ac962000ad322a695a8bf005830e561c34d87a8615dbccef0cc8ac709f',
     x86_64: 'a1fdf786034788a670726993caa6b22243caf2dd7a5f94de1dba92c261884bd3'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
