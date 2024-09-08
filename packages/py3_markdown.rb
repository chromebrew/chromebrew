require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version '3.7-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e5bc467aed13ab555396dd0a8fee5ae2757c41aa30c7eb8513cc3468ed8e2f8',
     armv7l: '6e5bc467aed13ab555396dd0a8fee5ae2757c41aa30c7eb8513cc3468ed8e2f8',
       i686: 'dd2cd5daa402f16be48f7282ccd822405cffc02cc1e1fd824e623fe727e29b6a',
     x86_64: 'a178f3131d330ce5c33cbff3bf5ff762fb32b996fcc06510033051a2980b9a01'
  })

  depends_on 'python3'
end
