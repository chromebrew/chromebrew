require 'package'

class Py3_dnspython < Package
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  @_ver = '2.1.0'
  version @_ver
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/rthalley/dnspython.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0_armv7l/py3_dnspython-2.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0_armv7l/py3_dnspython-2.1.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0_i686/py3_dnspython-2.1.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dnspython/2.1.0_x86_64/py3_dnspython-2.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '88bb279608f84d8db142bc0011d7c33910ff4d67046a433d2967c9232b065902',
     armv7l: '88bb279608f84d8db142bc0011d7c33910ff4d67046a433d2967c9232b065902',
       i686: '880fd78e0e2c772bdaf2661b362b5f2ed32615535a49a1ea1a1a65f3052775bd',
     x86_64: '52c717cb5ad0943c6067ea0e09a69e47c7b15e8d9ec6d1ab7a109d149530781a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
