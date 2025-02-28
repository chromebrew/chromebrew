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
    aarch64: 'e0129fe956eca16987bf00d516b548b7c9cf22107cafccaf450aa8cf8a2b78d7',
     armv7l: 'e0129fe956eca16987bf00d516b548b7c9cf22107cafccaf450aa8cf8a2b78d7',
       i686: '65f877e2a0f351b8c68cde54ab909df3f48609e3688297a55b23c2bf4a810e41',
     x86_64: '96e0b3bb433cfd78e4d113a4c84a91b47c6fd678123e95dc982e14e2fe328e4f'
  })

  depends_on 'python3' => :build

  no_source_build
end
