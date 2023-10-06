require 'buildsystems/python'

class Py3_openpyxl < Python
  description 'Openpyxl is a Python library to read/write Excel 2010 xlsx/xlsm files.'
  homepage 'https://openpyxl.readthedocs.io/'
  @_ver = '3.1.2'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/42/e8/af028681d493814ca9c2ff8106fc62a4a32e4e0ae14602c2a98fc7b741c8/openpyxl-3.1.2.tar.gz'
  source_sha256 'a6f5977418eff3b2d5500d54d9db50c8277a368436f4e4f8ddb1be3422870184'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.1.2-py3.12_armv7l/py3_openpyxl-3.1.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.1.2-py3.12_armv7l/py3_openpyxl-3.1.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.1.2-py3.12_i686/py3_openpyxl-3.1.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_openpyxl/3.1.2-py3.12_x86_64/py3_openpyxl-3.1.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd051a09a1e07fdc0a8fcdbb7638e4dfbf5647fbd08bc1570f8f6575b179c9090',
     armv7l: 'd051a09a1e07fdc0a8fcdbb7638e4dfbf5647fbd08bc1570f8f6575b179c9090',
       i686: '018c292322d00d2e3505bb303ff20411b527f626c1be9c053e3d10b3ce9f8edb',
     x86_64: '430dfbd257a078b52f06e5ca0b7d88fdee1dac408dd5ddeafb6ab55a2b3b3034'
  })

  depends_on 'py3_et_xmlfile'
  depends_on 'python3' => :build
end
