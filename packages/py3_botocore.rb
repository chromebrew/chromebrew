require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.25-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '767768065c03dde4c86a8a7028fe086e8ee033b6941ca812dfceba36631c87f2',
     armv7l: '767768065c03dde4c86a8a7028fe086e8ee033b6941ca812dfceba36631c87f2',
       i686: '1010368d0e63f83809f27c239e2ccac8cb57fc5d72117f278ad33ea7317237fd',
     x86_64: '2dc94a5ee250cb9ac8a04b382bd99a198cad6b60fc58ac96bbf1c1d5e4d553f1'
  })

  depends_on 'python3' => :logical

  no_source_build
end
