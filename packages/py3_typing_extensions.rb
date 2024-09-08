require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version '4.12.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python/typing.git'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build
end
