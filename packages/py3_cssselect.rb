require 'buildsystems/pip'

class Py3_cssselect < Pip
  description 'CSSselect parses CSS3 Selectors and translates them to XPath 1.0.'
  homepage 'https://cssselect.readthedocs.io/'
  version "1.2.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c50ef7fd01464ea6bfabfea009aeeb45937572cac170faef9e0b750a86f0d88',
     armv7l: '5c50ef7fd01464ea6bfabfea009aeeb45937572cac170faef9e0b750a86f0d88',
       i686: '5037c6e0f25d7d9df2c3494771ac84674c73ac9030f62730a745fe3f16cc24ee',
     x86_64: 'c14666bae8757c96533a6d988efc059b53f6d2490a39b0906a970383041e86b4'
  })

  depends_on 'python3' => :build

  no_source_build
end
