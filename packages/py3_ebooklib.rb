require 'buildsystems/pip'

class Py3_ebooklib < Pip
  description 'Ebooklib is a Python E-book library for handling books in EPUB2/EPUB3 format.'
  homepage 'https://docs.sourcefabric.org/projects/ebooklib/'
  version "0.21-#{CREW_PY_VER}"
  license 'AGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd1a0cd8ceb38f987402946580c3d7b1881fb445ee0887c1ec5d9a426e7498ec',
     armv7l: 'fd1a0cd8ceb38f987402946580c3d7b1881fb445ee0887c1ec5d9a426e7498ec',
       i686: 'e0d89b9ee7ed1059e42cbc79db4b868c550ccd058303f5246b98b18f7f8e4ede',
     x86_64: 'cef5e55a1f155bc199731f2600f40fcd94ea64acfb88890fa26f9c0e67fec269'
  })

  depends_on 'py3_lxml' # R
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
