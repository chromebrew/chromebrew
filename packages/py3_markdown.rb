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
    aarch64: '28c3649a591bc1b55da7aa7e183f4ec131717b7a0e1f6bf250d80faf4f8a1322',
     armv7l: '28c3649a591bc1b55da7aa7e183f4ec131717b7a0e1f6bf250d80faf4f8a1322',
       i686: 'f2e0e42b398eeaa1d351b4b9a5860ab5ad1ccaf4b5b737510e1d0a37322002a7',
     x86_64: '790094c6f86dadb8a58ac6e8a07bfe90bf4fbc17d44222aaf043e457f1494856'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
