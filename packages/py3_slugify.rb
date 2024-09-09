require 'buildsystems/pip'

class Py3_slugify < Pip
  description 'Python-slugify returns unicode slugs.'
  homepage 'https://github.com/un33k/python-slugify/'
  version '0.0.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'py3_text_unidecode'
  depends_on 'python3' => :build

  no_source_build
end
