require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2024.10.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9684d45e3a65953970d1e9158c38cbe4a2c90121ab833f9f02ed8cb39e6b3c70',
     armv7l: '9684d45e3a65953970d1e9158c38cbe4a2c90121ab833f9f02ed8cb39e6b3c70',
       i686: 'c3bdfaf0c12270481909dba07a19cbebba56476146492b9430876d0b3f2482ff',
     x86_64: '061bf133ba6aa28e25ec19c04bfbd0844c13c0c2db3b5f6517d5dd3c66bced65'
  })

  depends_on 'python3' => :build

  no_source_build
end
