require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.9.9.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b987ab33220cc1fb75b5c735b9c20f5fb76df392ce285a7723e840f6366884a',
     armv7l: '5b987ab33220cc1fb75b5c735b9c20f5fb76df392ce285a7723e840f6366884a',
       i686: '93edc17d3bbd890c53d366fd5f3e948c20a957202a7809eda7409791b06d58d1',
     x86_64: '9ca48bc10abbe46567c568c3c380a7353499766649ca9fdce519b70cf11504dc'
  })

  depends_on 'python3' => :build

  no_source_build
end
