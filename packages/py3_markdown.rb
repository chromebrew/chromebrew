require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.10.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43a8749fffa40537189101d9890b1b2c564beab78d3a5ab59d39a5aef0e47e5d',
     armv7l: '43a8749fffa40537189101d9890b1b2c564beab78d3a5ab59d39a5aef0e47e5d',
       i686: 'ae83b37494d4c7e54f82efec2a7eabc50a421c05e30c1e99cc8c27053040fc8e',
     x86_64: '805436e8c3df806f6729b3afdc006a724d2cd9c300c01d715116bbb8c9592a07'
  })

  depends_on 'python3'

  no_source_build
end
