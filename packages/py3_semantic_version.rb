require 'buildsystems/pip'

class Py3_semantic_version < Pip
  description 'Semantic version implements the SemVer scheme.'
  homepage 'https://github.com/rbarrois/python-semanticversion/'
  version "2.10.0-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
  })

  depends_on 'python3' => :build

  no_compile_needed
end
