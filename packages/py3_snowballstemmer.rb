require 'buildsystems/pip'

class Py3_snowballstemmer < Pip
  description 'Snowball stemming library collection for Python'
  homepage 'https://snowballstem.org'
  version "2.2.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({})

  depends_on 'py3_pystemmer'
  depends_on 'python3'
end
