require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.14.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82f444936d00155f6d9ff57841fc2d224bb02b245c4c2f0027e46d1270ddc57f',
     armv7l: '82f444936d00155f6d9ff57841fc2d224bb02b245c4c2f0027e46d1270ddc57f',
       i686: '60170f8304239b6d2ead9cbcd2fbfa682857f266df5686b0dcff3d201d1d8a7a',
     x86_64: '0d07947d42aa64aa98db289de6ba7c8dac0597cfe03ef136939112d8ee61f596'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
