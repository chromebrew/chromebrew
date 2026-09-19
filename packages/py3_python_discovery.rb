require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.6.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ae8b3cd14c8bc29080b72a61c6ee84da62d6adcc02b22b6884350d4f8bcc6ea',
     armv7l: '7ae8b3cd14c8bc29080b72a61c6ee84da62d6adcc02b22b6884350d4f8bcc6ea',
       i686: 'e7deae02d8f9f4edf50f58d7929658105ff2c3234a6f5a72e21dc6d4d35991c5',
     x86_64: 'c47cfcaa8a75c2265ae9c72283f23864d64b79bb40e2f1f41efa612405b7adae'
  })

  depends_on 'python3' => :logical

  no_source_build
end
