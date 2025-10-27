require 'buildsystems/pip'

class Py3_ebooklib < Pip
  description 'Ebooklib is a Python E-book library for handling books in EPUB2/EPUB3 format.'
  homepage 'https://docs.sourcefabric.org/projects/ebooklib/'
  version "0.20-#{CREW_PY_VER}"
  license 'AGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '834cc71a9b93a49500d6327cc0bb098a2a937ab5148efe94eea2c90aad60c399',
     armv7l: '834cc71a9b93a49500d6327cc0bb098a2a937ab5148efe94eea2c90aad60c399',
       i686: '10a1d08fd99c73c738ae9587b813d2d2497b35c673285ce714a9c227e0c34d69',
     x86_64: 'ad71821b37df741c9d60bebd1653a9f2d486cdad16d649ead5b17c0f5069b5e0'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
