require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.387-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7cbd073105c63c70e98190acb563427a596c8a4597e03eb61b8f31cc8bffd4ec',
     armv7l: '7cbd073105c63c70e98190acb563427a596c8a4597e03eb61b8f31cc8bffd4ec',
       i686: '0409c0727fd8c209900a386e3716d18f1de698b0de993876b064ac43431f3c5a',
     x86_64: '6b4cc484ad22ef6d3e36da18ae13e9e32053c4e1c3e2fc2201560398d6718644'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
