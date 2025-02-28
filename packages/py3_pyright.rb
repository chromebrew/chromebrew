require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.395-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99eb4e2b86139a8402fecd5a55d60f20d27fc3646bcd284ca204707cc66c49d7',
     armv7l: '99eb4e2b86139a8402fecd5a55d60f20d27fc3646bcd284ca204707cc66c49d7',
       i686: '5f5b61184a2e3c54707d2dd12e831754c9d3e7e61d113b39139447b901ea3738',
     x86_64: 'dcf33995ad03f434b7173a8e66d7e7fe0c3093046e886ce01c08602b37f4273e'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
