require 'package'

class Py3_olefile < Package
  description 'Olefile is a Python package to parse, read and write Microsoft OLE2 files.'
  homepage 'https://www.decalage.info/python/olefileio/'
  @_ver = '0.46'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/decalage2/olefile.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-py3.11_armv7l/py3_olefile-0.46-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-py3.11_armv7l/py3_olefile-0.46-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-py3.11_i686/py3_olefile-0.46-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-py3.11_x86_64/py3_olefile-0.46-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6e16de741ff562ac8b4f0b6b5af5a2b2521d3c512dd0534609b0cf994eb18b3d',
     armv7l: '6e16de741ff562ac8b4f0b6b5af5a2b2521d3c512dd0534609b0cf994eb18b3d',
       i686: '9f331d07d6443ae226939c1afbd83c9a98860d831f1372fa4ac940c56a49e75e',
     x86_64: '5d71419582c752f10df1be75c0547722fa3b376e40b21f24f6ee03f4c7e56df0'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
