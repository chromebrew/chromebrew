require 'package'

class Py3_pycryptodome < Package
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  @_ver = '3.11.0'
  version @_ver
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'https://github.com/Legrandin/pycryptodome.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0_armv7l/py3_pycryptodome-3.11.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0_armv7l/py3_pycryptodome-3.11.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0_i686/py3_pycryptodome-3.11.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodome/3.11.0_x86_64/py3_pycryptodome-3.11.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '884855a60bb657f148b3fce8b2c0446798ab5fd8384b0251eb46ec9d2e0a96f1',
     armv7l: '884855a60bb657f148b3fce8b2c0446798ab5fd8384b0251eb46ec9d2e0a96f1',
       i686: '8451ba51a8d64c9e0c4d64672cf59ba831dcaca9c0312b8817ea719d5105d7d4',
     x86_64: 'f6d66c3c8d273d485b54d64b412ebe47a594eaa7c28f3152d4c43f8bc69184ca'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
