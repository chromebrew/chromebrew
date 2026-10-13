require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.14.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ee181ef49a7b02bbf27b96bc97f6efb74184d51ddf68636092dd2dd28af5f29',
     armv7l: '1ee181ef49a7b02bbf27b96bc97f6efb74184d51ddf68636092dd2dd28af5f29',
       i686: 'fee687d6b27ac028ed771af100ce43d8d41790bac6ff8e823bbfa546104f75da',
     x86_64: '8bae02e965dedda10295a5f2b2cc2a18859ab540170bf8b67c03b615023f86f3'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
