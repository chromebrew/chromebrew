require 'buildsystems/python'

class Py3_pytimeparse < Python
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  version '1.1.8-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wroberts/pytimeparse.git'
  version '1.1.8-py3.12'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build
end
