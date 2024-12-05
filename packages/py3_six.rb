require 'buildsystems/pip'

class Py3_six < Pip
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  version "1.17.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9cd488ed17b7751201619be71e005fa9999ab67adc40085fde8e54b629467e2',
     armv7l: 'c9cd488ed17b7751201619be71e005fa9999ab67adc40085fde8e54b629467e2',
       i686: '193b269ced09120a68f580210e733472af23e6e40bac59b25983d2214140bed0',
     x86_64: '578093e9b2902f8e832e8b4e6ed14db6bf25258097494e1958ba63e8652ffaa4'
  })

  depends_on 'python3' => :build

  no_source_build
end
