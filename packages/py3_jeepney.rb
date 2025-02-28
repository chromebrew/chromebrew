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
    aarch64: '149eddc2afc91678f0dfa1643dbe7a9dd300c2820299a446b67d26e28171b9c8',
     armv7l: '149eddc2afc91678f0dfa1643dbe7a9dd300c2820299a446b67d26e28171b9c8',
       i686: '65f877e2a0f351b8c68cde54ab909df3f48609e3688297a55b23c2bf4a810e41',
     x86_64: '5e59ff1bcc9ebe8735aaeae7083274db56b1382cc235a2743f657740d5299ccc'
  })

  depends_on 'python3' => :build

  no_source_build
end
