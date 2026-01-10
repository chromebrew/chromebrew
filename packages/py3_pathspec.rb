require 'buildsystems/pip'

class Py3_pathspec < Pip
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-pathspec'
  version "1.0.3-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '553c6d5b73511c89f1f1583ceb307ee079105d77e4509cfcd8cae977e475d3c8',
     armv7l: '553c6d5b73511c89f1f1583ceb307ee079105d77e4509cfcd8cae977e475d3c8',
       i686: 'de765610afb27a5b297c3b4937c9fedf07835157bae72f5708c934dcacb60214',
     x86_64: 'e81536215782f01638adc085dab3b092814c097923d4c0709140899adf66d011'
  })

  depends_on 'python3' => :build

  no_source_build
end
