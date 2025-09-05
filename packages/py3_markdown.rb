require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.9-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '241f5da7ba19c4dfbd28b542b4c7602d790db8d70e63769f6232be177d15f64b',
     armv7l: '241f5da7ba19c4dfbd28b542b4c7602d790db8d70e63769f6232be177d15f64b',
       i686: 'c2121cf28f4920ede2f03d959c644ac402fe738f9362834077bbbf09bed1e2c7',
     x86_64: '40f82e1940e4e70245489ff03820632ed5c09a0b55874392c2428c0eb05e3ce0'
  })

  depends_on 'python3'

  no_source_build
end
