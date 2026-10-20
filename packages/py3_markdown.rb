require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.11.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '81c657470972fc00beb4fc5453183a4da96dfbabd417c3945afd29bf8f182fe0',
     armv7l: '81c657470972fc00beb4fc5453183a4da96dfbabd417c3945afd29bf8f182fe0',
       i686: 'cde3e191d5e4729fbe8b7bfd7e3f1c6c950a92a4c49ee2f3c18540866a8820d5',
     x86_64: '6dad09b3aaf6a0a310b1a88815e6845e4f33b73118cdeb32c0abfa50114d5ee2'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
