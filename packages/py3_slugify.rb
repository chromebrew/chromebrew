require 'buildsystems/python'

class Py3_slugify < Python
  description 'Python-slugify returns unicode slugs.'
  homepage 'https://github.com/un33k/python-slugify/'
  @_ver = '8.0.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/un33k/python-slugify.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/8.0.1-py3.12_armv7l/py3_slugify-8.0.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/8.0.1-py3.12_armv7l/py3_slugify-8.0.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/8.0.1-py3.12_i686/py3_slugify-8.0.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_slugify/8.0.1-py3.12_x86_64/py3_slugify-8.0.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2d8c92cd76a40a41236066b7b5586069bc8ca6bdc470fea6b22aecd0bf1a28d8',
     armv7l: '2d8c92cd76a40a41236066b7b5586069bc8ca6bdc470fea6b22aecd0bf1a28d8',
       i686: 'b22aeebc97af118fe95e4a60264a5e6164beb2633427cc947fb56d5b0e82b4c0',
     x86_64: '3b767c2fe1571fef3ce7167230ce5d7b2acdaaab4ec25055ee9117bf1b728df3'
  })

  depends_on 'py3_text_unidecode'
  depends_on 'python3' => :build
end
