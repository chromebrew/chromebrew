require 'buildsystems/pip'

class Py3_pygments < Pip
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  version "2.21.0-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50e6f2ff4d1643662735a47fad38d419a56a2bc907d01d8dbc1f27a33231ac8f',
     armv7l: '50e6f2ff4d1643662735a47fad38d419a56a2bc907d01d8dbc1f27a33231ac8f',
       i686: 'e7f9bd8ffb8d39365ded4a0cf1971de28d898515c2ff733d07ba8ef8ca54769d',
     x86_64: 'ed0cd23d879df90ac0d8b78be99a4b1eef65017593150c50bc5c278970a0aea6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
