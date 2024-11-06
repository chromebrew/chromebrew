require 'buildsystems/pip'

class Py3_slugify < Pip
  description 'Python-slugify returns unicode slugs.'
  homepage 'https://github.com/un33k/python-slugify/'
  version "0.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8bc7d2ea3ab799c2153922a5bdcd8b2ace9a1520f12b1092f2500cec45105090',
     armv7l: '8bc7d2ea3ab799c2153922a5bdcd8b2ace9a1520f12b1092f2500cec45105090',
       i686: 'fdeceb5b3c84b475e07782e45600f677394606c781fa952c0d4213930b7aee8d',
     x86_64: '7723047cd546b00fc1b5a43448dad55669aacdf3ff7559515f6db87eacdb8ee4'
  })

  depends_on 'py3_text_unidecode'
  depends_on 'python3' => :build

  no_source_build
end
