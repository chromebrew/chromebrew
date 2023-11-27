require 'buildsystems/pip'

class Dtrx < Pip
  description "An intelligent archive extraction tool for UNIX-like systems standing for 'Do The Right Extraction.'"
  homepage 'https://github.com/dtrx-py/dtrx/'
  @_ver = '8.5.3'
  version "#{@_ver}-py3.12"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({})
  binary_sha256({})

  depends_on 'py3_unsupported_python' => :build
  depends_on 'python3' => :build
end
