require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version "4.12.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1a7c60763366f30be0ab792a12353df67ed57e7dbfa71bb825a270daf9cd6f95',
     armv7l: '1a7c60763366f30be0ab792a12353df67ed57e7dbfa71bb825a270daf9cd6f95',
       i686: '25087e83bde086d565cb7c12d66fe27c08e36d0bd73d50f1c0e35fe55557d8fa',
     x86_64: '74a0904ff35215c90aa8fcec91b26f487f9e0aea0b15615f646d2bb4e124b1b5'
  })

  depends_on 'python3' => :build

  no_source_build
end
