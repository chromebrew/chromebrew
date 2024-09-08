require 'buildsystems/pip'

class Py3_slugify < Pip
  description 'Python-slugify returns unicode slugs.'
  homepage 'https://github.com/un33k/python-slugify/'
  version '0.0.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d8c92cd76a40a41236066b7b5586069bc8ca6bdc470fea6b22aecd0bf1a28d8',
     armv7l: '2d8c92cd76a40a41236066b7b5586069bc8ca6bdc470fea6b22aecd0bf1a28d8',
       i686: 'b22aeebc97af118fe95e4a60264a5e6164beb2633427cc947fb56d5b0e82b4c0',
     x86_64: '3b767c2fe1571fef3ce7167230ce5d7b2acdaaab4ec25055ee9117bf1b728df3'
  })

  depends_on 'py3_text_unidecode'
  depends_on 'python3' => :build
end
