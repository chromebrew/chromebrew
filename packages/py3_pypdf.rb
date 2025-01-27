require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.2.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a4aa77a07e034d54b351e7b93381db9a7764bbb178254ee040e2743cc63d378',
     armv7l: '2a4aa77a07e034d54b351e7b93381db9a7764bbb178254ee040e2743cc63d378',
       i686: 'b4a0f4ec7f3082564ba2d98824980a96c2ffb442fef1d9c23afb43950b7067be',
     x86_64: 'b5f252445682ecffdcee0bbf2d6e6578f052deaabf07fbbdc4c02439e9b67c77'
  })

  depends_on 'python3'

  no_source_build
end
