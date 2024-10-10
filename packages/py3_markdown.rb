require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.7-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd363fcf11925c974f1a89c480b19c833a37c5691c941020035a260b697c46b7e',
     armv7l: 'd363fcf11925c974f1a89c480b19c833a37c5691c941020035a260b697c46b7e',
       i686: '77421424a98933f74abb850c2d839068aea22fe463cbe4c4822a63cc1b411974',
     x86_64: 'd8929bd6ffc46edd40182ae08a2cffab8e35e849e8da72e86d874cd5c9abcdbf'
  })

  depends_on 'python3'

  no_source_build
end
