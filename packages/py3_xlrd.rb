require 'buildsystems/pip'

class Py3_xlrd < Pip
  description 'XLRD is a library to extract data from Microsoft Excel (tm) spreadsheet files.'
  homepage 'https://xlrd.readthedocs.io/'
  version "2.0.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1a02ad5ed55435cb09572710171bb9046e2d29e8caec211bd0619b75629d068',
     armv7l: 'e1a02ad5ed55435cb09572710171bb9046e2d29e8caec211bd0619b75629d068',
       i686: '5d40727569aa1537230137df8015048982872482c1eee2322f31e6cefca3fab3',
     x86_64: 'f242f03e316d62a71e228401502c6fa392a96a8b0ba7815ccd055bac7ee8477c'
  })

  depends_on 'python3' => :build

  no_source_build
end
