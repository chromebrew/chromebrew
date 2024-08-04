require 'buildsystems/pip'

class Py3_cfgv < Pip
  description 'Validate configuration and produce human readable error messages.'
  homepage 'https://pypi.org/project/cfgv/#data'
  version '3.4.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed

end
