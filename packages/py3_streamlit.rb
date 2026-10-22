require 'buildsystems/pip'

class Py3_streamlit < Pip
  description 'A faster way to build and share data apps'
  homepage 'https://streamlit.io/'
  version "1.66.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'de01d2c13e0b0c558b20a5844699178d23ec71b5e656b51b90309c7264aeb3d5',
     armv7l: 'de01d2c13e0b0c558b20a5844699178d23ec71b5e656b51b90309c7264aeb3d5',
       i686: '99443a8e2ed1a4b6222b76037961d2385830b118a1e85722b54672a10441c64f',
     x86_64: '4fd7a8d20864fdc6fa5b86de46633fc981eb507fc924f199384feb9d7c1bf5ab'
  })

  depends_on 'python3' => :logical

  no_source_build
end
