require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.5.9.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ca900124f956975d9173cf59cc5c9ad44ae61e862c9a6579cde95889b9c4719',
     armv7l: '2ca900124f956975d9173cf59cc5c9ad44ae61e862c9a6579cde95889b9c4719',
       i686: 'd729fbf72fc8b6cc06a6c901cca1f78dcf7381b5b7e6db202e65283a05dec206',
     x86_64: 'c1c89c3567b887bf5f81e292481fb07f2390b833ebb35fb25bf3d6a15658508e'
  })

  depends_on 'python3' => :build

  no_source_build
end
