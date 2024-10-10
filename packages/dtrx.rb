require 'buildsystems/pip'

class Dtrx < Pip
  description "An intelligent archive extraction tool for UNIX-like systems standing for 'Do The Right Extraction.'"
  homepage 'https://github.com/dtrx-py/dtrx/'
  version "8.5.3-#{CREW_PY_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({})

  depends_on 'py3_unsupported_python' => :build
  depends_on 'python3' => :build

  no_source_build
end
