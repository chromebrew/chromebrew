require 'buildsystems/pip'

class Py3_pytimeparse < Pip
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  version '1.1.8-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build
end
