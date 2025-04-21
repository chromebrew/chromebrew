require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.8-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7bd555a3350a4e6ba3abe7d3068197a4969e4edd23ad0bca9a8cd367b122db5',
     armv7l: 'f7bd555a3350a4e6ba3abe7d3068197a4969e4edd23ad0bca9a8cd367b122db5',
       i686: '5502206b4a94ae0ccdfc4de92446db66cb1acaf537cf69e4e9f5dece0441bf40',
     x86_64: '38d983f8cbd7511f8bfb60697ddf0efff6f3e605206e31699ef8c74bfe990e40'
  })

  depends_on 'python3'

  no_source_build
end
