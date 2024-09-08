require 'buildsystems/pip'

class Py3_openpyxl < Pip
  description 'Openpyxl is a Python library to read/write Excel 2010 xlsx/xlsm files.'
  homepage 'https://openpyxl.readthedocs.io/'
  version '3.1.5-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd051a09a1e07fdc0a8fcdbb7638e4dfbf5647fbd08bc1570f8f6575b179c9090',
     armv7l: 'd051a09a1e07fdc0a8fcdbb7638e4dfbf5647fbd08bc1570f8f6575b179c9090',
       i686: '018c292322d00d2e3505bb303ff20411b527f626c1be9c053e3d10b3ce9f8edb',
     x86_64: '430dfbd257a078b52f06e5ca0b7d88fdee1dac408dd5ddeafb6ab55a2b3b3034'
  })

  depends_on 'py3_et_xmlfile'
  depends_on 'python3' => :build
end
