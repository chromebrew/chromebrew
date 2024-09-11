require 'buildsystems/pip'

class Py3_pathspec < Pip
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-pathspec'
  version '0.12.1-py3.12'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '818cdce154415247f9526dada829889bcccd14100637f710b0d6a5d869a54532',
     armv7l: '818cdce154415247f9526dada829889bcccd14100637f710b0d6a5d869a54532',
       i686: 'ad543a8163973d6c06612f0ebe4cb8b4da6d3092281c776dff09dec4069d99d7',
     x86_64: '6f25c201e9387795091ba84ad0eb98d5929811f7cca8da31b520a0a937d8c023'
  })

  depends_on 'python3' => :build

  no_source_build
end
