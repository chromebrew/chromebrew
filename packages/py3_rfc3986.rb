require 'buildsystems/pip'

class Py3_rfc3986 < Pip
  description 'A Python implementation of RFC 3986 including validation and authority parsing.'
  homepage 'http://rfc3986.readthedocs.io'
  version "2.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
