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
    aarch64: '922a9956e93860e0147dd3e6469d3df40c30ae2f7577b68e803d2bffa62401ee',
     armv7l: '922a9956e93860e0147dd3e6469d3df40c30ae2f7577b68e803d2bffa62401ee',
       i686: '1d91c14ec35a6f643d490efcb28b62e9acead390d2ad68c8449c3f31eca49b3f',
     x86_64: 'a2b09c0ece6bff7b731d8d0213204af77e88da6580b10eefa7b6e9983671579e'
  })

  depends_on 'python3' => :build

  no_source_build
end
