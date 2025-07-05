require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version "4.14.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c04b7082b4fbf7b7ae64bd7a468ae07bdf9f8337f94c2566a082311f44b5d79',
     armv7l: '1c04b7082b4fbf7b7ae64bd7a468ae07bdf9f8337f94c2566a082311f44b5d79',
       i686: 'e2a4917910eb10b4a3a40771b104a540e612392e141d0d63c6bee5a76a96cc27',
     x86_64: '78c5314be26136ab8cfb3133907402060fd14ff08b4d5edf0302dd660bc20f2c'
  })

  depends_on 'python3' => :build

  no_source_build
end
