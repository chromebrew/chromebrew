require 'buildsystems/pip'

class Py3_id < Pip
  description 'Python tool for generating OIDC identities.'
  homepage 'https://pypi.org/project/id'
  version "1.5.0-#{CREW_PY_VER}"
  license 'Apache'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
  })

  depends_on 'python3' => :build

  no_compile_needed
end
