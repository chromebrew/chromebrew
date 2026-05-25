require 'buildsystems/pip'

class Py3_snowballstemmer < Pip
  description 'Snowball stemming library collection for Python'
  homepage 'https://snowballstem.org'
  version "3.1.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc71a0d94098773d907d3d5f2df39b49e7e92ec056956bf777dfcb92beafbe10',
     armv7l: 'fc71a0d94098773d907d3d5f2df39b49e7e92ec056956bf777dfcb92beafbe10',
       i686: '9b93274a65f2980e618303ae244ec16a7654d3249abfb10b4264567e8fc6ec13',
     x86_64: 'ef2ff9a27f23ba137e209d6e3f08ef3e0bfa2ae7d43653dcdf36a1e022270350'
  })

  depends_on 'py3_pystemmer'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
