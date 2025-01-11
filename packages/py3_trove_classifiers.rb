require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.1.10.15-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08c8b6a07b74a99e79350950225159f2886fc60879dde2e68b8b9747312705b2',
     armv7l: '08c8b6a07b74a99e79350950225159f2886fc60879dde2e68b8b9747312705b2',
       i686: 'ce9e2f517f476d1787042615dd7db98bcffcde179db560b3a4391be3696cad45',
     x86_64: 'd041fce42b387152df9155deb694c073b18de88e2ce7fe5a53b10fbb221f7a1a'
  })

  depends_on 'python3' => :build

  no_source_build
end
