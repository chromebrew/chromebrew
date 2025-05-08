require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.5.8.15-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae69b318a919b7bfd0c004831d6fce67e86b897dfbbd38dd56181a08824f3fc3',
     armv7l: 'ae69b318a919b7bfd0c004831d6fce67e86b897dfbbd38dd56181a08824f3fc3',
       i686: '3e6b3dc100d2aba3ca32fbdf4dae25d80a79d1f2fd9816c531c7c4995c600f6a',
     x86_64: 'c1c89c3567b887bf5f81e292481fb07f2390b833ebb35fb25bf3d6a15658508e'
  })

  depends_on 'python3' => :build

  no_source_build
end
