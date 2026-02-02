require 'buildsystems/pip'

class Py3_babel < Pip
  description 'Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications.'
  homepage 'https://babel.pocoo.org/'
  version "2.18.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51a4369986587626f0fdefc03428a7d9e16d9a893eb7475e248f79035f249c3e',
     armv7l: '51a4369986587626f0fdefc03428a7d9e16d9a893eb7475e248f79035f249c3e',
       i686: '97ffe971cab33d04914a3450309c62ef36bd9f382dd78c2dfa00e368e54668bd',
     x86_64: 'a0800430e2b67c2a1b33fc09ed6c7d3361cb91da6f78b246ccc8c3f785185cf8'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  no_source_build
end
