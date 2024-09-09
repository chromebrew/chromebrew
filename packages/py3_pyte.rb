require 'buildsystems/pip'

class Py3_pyte < Pip
  description 'PyTE is a Simple VTXXX-compatible terminal emulator.'
  homepage 'https://github.com/selectel/pyte/'
  version '0.8.2-py3.12'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'py3_wcwidth'
  depends_on 'python3' => :build

  no_source_build
end
