require 'buildsystems/pip'

class Py3_cfgv < Pip
  description 'Validate configuration and produce human readable error messages.'
  homepage 'https://github.com/asottile/cfgv'
  version "3.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
