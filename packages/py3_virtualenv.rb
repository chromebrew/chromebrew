require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.31.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd756914d42a4146bc9679b9bb2414f8a5d28ef9cfacfe314d6bfb05fc7a10a1c',
     armv7l: 'd756914d42a4146bc9679b9bb2414f8a5d28ef9cfacfe314d6bfb05fc7a10a1c',
       i686: '77f786f817a8589fd51240c9bd18f57a8279280510881ecbb934bac82980ca08',
     x86_64: '3e2cd63fb04cc13f33ef6434290911dd8881424290412d557cb39c018658c684'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
