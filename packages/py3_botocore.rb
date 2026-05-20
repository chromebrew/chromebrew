require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.11-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a2eb21726ede1bf2ca7683ff9a7891f98997b63066f55a33eea56a413b58a760',
     armv7l: 'a2eb21726ede1bf2ca7683ff9a7891f98997b63066f55a33eea56a413b58a760',
       i686: '2e2b338e263da85146b046888f168688fa4ca0cb067f0de5997ac88d354da92d',
     x86_64: '576c68b131dce29cd8ce37fbd8c857ff8ccd2694fff6ad301159d2b722113d89'
  })

  depends_on 'python3' => :logical

  no_source_build
end
