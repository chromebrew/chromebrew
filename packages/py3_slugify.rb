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
    aarch64: 'b7d6bd595dcec754410221adeb53b808ad731557d4e3de8556cba339ed507cad',
     armv7l: 'b7d6bd595dcec754410221adeb53b808ad731557d4e3de8556cba339ed507cad',
       i686: '926ab96dfbaf5b60088ae831a5ac02c8d4c9e271e0fe9c5fd24e5f7a6273e510',
     x86_64: '19b65d375f8a4ff6e4e5ab6b7e5686aee638a306e7a6d33db200f06abd43141f'
  })

  depends_on 'py3_text_unidecode'
  depends_on 'python3' => :logical

  no_source_build
end
