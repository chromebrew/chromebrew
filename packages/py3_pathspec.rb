require 'buildsystems/pip'

class Py3_pathspec < Pip
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-pathspec'
  version "1.1.1-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52de7b58e4ada98b20033c030122f18e46c433aa4adcfac05d8bacc1cade9c37',
     armv7l: '52de7b58e4ada98b20033c030122f18e46c433aa4adcfac05d8bacc1cade9c37',
       i686: '7a3f0d8c02d1882286e271f321a68023ddb155661d37e45501cd70f405ee7f8e',
     x86_64: '8999a0294846fcd140b11325f41ce0a68dd6d1cd7b9030ab0513600099159aef'
  })

  depends_on 'python3' => :logical

  no_source_build
end
