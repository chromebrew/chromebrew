require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.1.7.14-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8c46091f9a03dcf4bcf49c8c184ff34f675f149dad637d62db5975539b6a3d1',
     armv7l: 'd8c46091f9a03dcf4bcf49c8c184ff34f675f149dad637d62db5975539b6a3d1',
       i686: '80706476d0e04da9fa614be6575bcde917c5f6d031146e20799e6102befc4eb3',
     x86_64: 'a0d5455eb3d3830ef6e771e8f2d35a9bbec536bb8820cfc083710daeff79742c'
  })

  depends_on 'python3' => :build

  no_source_build
end
