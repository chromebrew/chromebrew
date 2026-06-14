require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '709468b06f1e90013d07494bb19b0d6d507d981fc71796cf160c9a5c2e81ccd8',
     armv7l: '709468b06f1e90013d07494bb19b0d6d507d981fc71796cf160c9a5c2e81ccd8',
       i686: 'b802c83688644beffa1202fcc3929483c5210eeea9b0dc9654b765fb5bf37776',
     x86_64: '48d2598b8b1878e5a2091fabeb411cc2c2e3942d188e756537bd898ad5217d01'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
