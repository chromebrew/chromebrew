require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2026.10.23-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '415c037abc0c48cc1d3fe23fdf1648ba4bb3cf433403d4256080bde59ecd1469',
     armv7l: '415c037abc0c48cc1d3fe23fdf1648ba4bb3cf433403d4256080bde59ecd1469',
       i686: 'ecfc641b8341838217e64a9a97e32a85974cc0bfb1361fd5ac7894dbb5217da5',
     x86_64: 'ccb7caaf6c6eabcc3b0b79d9f787d41e22fa726d77d75c6f9c8703b1a0c3ff72'
  })

  depends_on 'python3' => :logical

  no_source_build
end
