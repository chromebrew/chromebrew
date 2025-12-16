require 'buildsystems/pip'

class Py3_agate_excel < Pip
  description 'Agate-excel read support for Excel files (xls and xlsx) to agate.'
  homepage 'https://agate-excel.readthedocs.io/'
  version "0.4.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ccd0f99f3f1da0f220bf694878c5ce77e29f7b51e140ed1a970660763fcac9c5',
     armv7l: 'ccd0f99f3f1da0f220bf694878c5ce77e29f7b51e140ed1a970660763fcac9c5',
       i686: 'ed23b3921a3fd0500e16606c1c57f2def47f2786c2b03872cc10e25052069659',
     x86_64: 'c328d5b3bcb2eca0d097105f96c6194c1cb66c031070f67e0ec10ebf91c2cf2d'
  })

  depends_on 'py3_xlrd'
  depends_on 'py3_openpyxl'
  depends_on 'py3_olefile'
  depends_on 'py3_agate'
  depends_on 'python3' => :build

  no_source_build
end
