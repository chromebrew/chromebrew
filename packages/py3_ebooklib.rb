require 'buildsystems/pip'

class Py3_ebooklib < Pip
  description 'Ebooklib is a Python E-book library for handling books in EPUB2/EPUB3 format.'
  homepage 'https://docs.sourcefabric.org/projects/ebooklib/'
  version "0.19-#{CREW_PY_VER}"
  license 'AGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe8f37d2b10ddad0ce3d04a3254305da85d5b1ffdd0a893351ff2e18e675286f',
     armv7l: 'fe8f37d2b10ddad0ce3d04a3254305da85d5b1ffdd0a893351ff2e18e675286f',
       i686: 'ca4a281396bc86ebe5610cf7ce05f4616f653a2f28ff968ef72526bef3a34ec1',
     x86_64: 'cd3df882bf9842fbbb821b8629e5c1c1f7eada8b971e2cb2a73075e73f7cb594'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
