require 'buildsystems/pip'

class Py3_markitdown < Pip
  description 'Python tool for converting files and office documents to Markdown.'
  homepage 'https://github.com/microsoft/markitdown'
  version "0.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36cd69c61ae1817edeec239eab4b3c4acc2359ac252f8e74374e3ec1fc55bd25',
     armv7l: '36cd69c61ae1817edeec239eab4b3c4acc2359ac252f8e74374e3ec1fc55bd25',
       i686: 'd85b462ed2b344bcb61b6bfa634d778d7f4937096a118bacdcd60aa2e52a0f13',
     x86_64: 'fdcfba7371bc75cddcd3e950db3543f7dc1a0e3ee628e5e360dbdbe5bdb4d985'
  })

  depends_on 'python3' => :build

  no_source_build
end
