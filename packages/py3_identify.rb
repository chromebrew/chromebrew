require 'buildsystems/pip'

class Py3_identify < Pip
  description 'File identification library for Python'
  homepage 'https://github.com/pre-commit/identify'
  version "2.6.15-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
  })

  depends_on 'python3' => :build

  no_compile_needed
end
