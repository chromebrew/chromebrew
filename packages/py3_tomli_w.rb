require 'buildsystems/pip'

class Py3_tomli_w < Pip
  description "Tomli-w is a lil' TOML writer."
  homepage 'https://github.com/hukkin/tomli-w/'
  version "1.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({})
end
