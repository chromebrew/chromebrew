require 'buildsystems/pip'

class Py3_jeepney < Pip
  description 'Jeepney is a low-level, pure Python DBus protocol wrapper.'
  homepage 'https://gitlab.com/takluyver/jeepney/'
  version "0.9.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1dd411511a07eaa98ab0ea1bcbf4a1f18f2ab6d5c9789c4acb0cf01b087f545c',
     armv7l: '1dd411511a07eaa98ab0ea1bcbf4a1f18f2ab6d5c9789c4acb0cf01b087f545c',
       i686: 'ed44898dbce2c2e2ff31e08e207e293a681d5ddbc7df3d7904e9403492dcc92e',
     x86_64: '9ec8ea98790dfbeb5f53a353cdae9801b0a3471e450937198876aedf858a3fab'
  })

  depends_on 'python3' => :logical

  no_source_build
end
