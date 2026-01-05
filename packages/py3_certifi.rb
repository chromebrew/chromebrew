require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2026.1.4-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab2ea29023ad2e00ab07225fd1ee69d28f59b4dfdb02702c31049a753ea261d5',
     armv7l: 'ab2ea29023ad2e00ab07225fd1ee69d28f59b4dfdb02702c31049a753ea261d5',
       i686: '5e3c5eb91ce2e243bfbd4aced6abf754d5428bebd81250e50a637919826c30d3',
     x86_64: '2410a97f84af74edb1d97624104e6890ae0ab72d8de8b88183d17882189eeb2d'
  })

  depends_on 'python3' # L

  no_source_build
end
