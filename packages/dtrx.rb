require 'buildsystems/pip'

class Dtrx < Pip
  description "An intelligent archive extraction tool for UNIX-like systems standing for 'Do The Right Extraction.'"
  homepage 'https://github.com/dtrx-py/dtrx/'
  version "8.7.1-#{CREW_PY_VER}"
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a1133ff86e4ed768b6d9977913d9e9e3bb50aabaf45d82e2ad6707a1bac2e400',
     armv7l: 'a1133ff86e4ed768b6d9977913d9e9e3bb50aabaf45d82e2ad6707a1bac2e400',
       i686: '97d068a182d9b8bf2980fa0c0a4164fda6077e4025101c95766a77a1669d64f0',
     x86_64: '2b1fa27068dfa21102078b6b8a68bdb3fd23d99c85141a8f6f34422ca0b0327a'
  })

  depends_on 'py3_unsupported_python' => :build
  depends_on 'python3' => :build

  no_source_build
end
