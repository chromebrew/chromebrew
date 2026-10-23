require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.118-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79da34e33f969328f08cdd4c4ddcb38525df41f78c27fdd5c27e2f616fed55f1',
     armv7l: '79da34e33f969328f08cdd4c4ddcb38525df41f78c27fdd5c27e2f616fed55f1',
       i686: '821ed2203daedbf422f28a017d54e976f801edc8797647d8a1424619c7c7e7bd',
     x86_64: '5a96189a15aed7e9ce19c48bbfe6591530405fbe6a41d2765aa345d9a4a04397'
  })

  depends_on 'python3' => :logical

  no_source_build
end
