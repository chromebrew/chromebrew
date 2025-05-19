require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.23.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94acabdb59a7677d6095dcc6aa28d1170049e4f6b4656bfe821aa82d26b3629a',
     armv7l: '94acabdb59a7677d6095dcc6aa28d1170049e4f6b4656bfe821aa82d26b3629a',
       i686: '134e51ea8f233f307c75e93b8d047d8640a7aedaf32edbc8827f59962d3ce6c6',
     x86_64: '7846e3b02a9a685ac6badfbf67ec03d98306bb7876581eeae596551048624aa7'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
