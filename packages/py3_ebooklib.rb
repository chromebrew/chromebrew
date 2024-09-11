require 'buildsystems/pip'

class Py3_ebooklib < Pip
  description 'Ebooklib is a Python E-book library for handling books in EPUB2/EPUB3 format.'
  homepage 'https://docs.sourcefabric.org/projects/ebooklib/'
  version '0.18-py3.12'
  license 'AGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b737aa6b618f2548f229bfa67efb8d1b66c5e55eb15ff3bc9a6c6456922cf6c1',
     armv7l: 'b737aa6b618f2548f229bfa67efb8d1b66c5e55eb15ff3bc9a6c6456922cf6c1',
       i686: 'fa53a88a3640442155f31f773e89b6dfc78502551828e84e1ee20da59af680d4',
     x86_64: '8a1126a6bfcc1ea9cf7b28e51b0575f94bb3bba66d438c7e5214c482935d8a35'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
