require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2026.6.1.19-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ed11c7265cb458946938291403db1dcd2e9337fbd93a8076a8c55612fb51345',
     armv7l: '6ed11c7265cb458946938291403db1dcd2e9337fbd93a8076a8c55612fb51345',
       i686: 'c8f2b1500f8c0204dff4e1994903f4c19358cff752c9598936778fbbdfeabd58',
     x86_64: '79f7a2928770770c44dd4455b4b3f1865b361cf31a372c8ae0a6023e043d90b6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
