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
    aarch64: 'd7b7f7addb43a911ca92a3c03725eeef7eb837db2846845464dfe2d0518532f3',
     armv7l: 'd7b7f7addb43a911ca92a3c03725eeef7eb837db2846845464dfe2d0518532f3',
       i686: '31ad50a93d78426a630f685efa02c1825e7546e7e614f537b04e655f6aae9a76',
     x86_64: 'cd3df882bf9842fbbb821b8629e5c1c1f7eada8b971e2cb2a73075e73f7cb594'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
