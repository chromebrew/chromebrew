require 'buildsystems/pip'

class Py3_leather < Pip
  description 'Leather is a fast, approximate chart generator in Python.'
  homepage 'https://leather.readthedocs.io/'
  version "0.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5fc7d3e45f0f332d1794d82dcb6f656777fa2a4ec12694418e3e1360aebc8857',
     armv7l: '5fc7d3e45f0f332d1794d82dcb6f656777fa2a4ec12694418e3e1360aebc8857',
       i686: '4e1a6d9f01dd17373499a1a57550ef3c1df590e899f4e61649f51df263451fd2',
     x86_64: '8a615f19b8480ccd34ca90d7d09bb9498b06ae9bfcd36f7b3f0d6f067aba9e2b'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
