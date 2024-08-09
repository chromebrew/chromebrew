require 'buildsystems/pip'

class Py3_cfgv < Pip
  description 'Validate configuration and produce human readable error messages.'
  homepage 'https://github.com/asottile/cfgv'
  version '3.4.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed

end
