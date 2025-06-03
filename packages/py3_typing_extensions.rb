require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version "4.14.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '87891049d34e295be53ffc7f9fc4f0ebb8eb425be1a0a66d549a10e95e5ad70d',
     armv7l: '87891049d34e295be53ffc7f9fc4f0ebb8eb425be1a0a66d549a10e95e5ad70d',
       i686: '1d91c14ec35a6f643d490efcb28b62e9acead390d2ad68c8449c3f31eca49b3f',
     x86_64: 'a2b09c0ece6bff7b731d8d0213204af77e88da6580b10eefa7b6e9983671579e'
  })

  depends_on 'python3' => :build

  no_source_build
end
