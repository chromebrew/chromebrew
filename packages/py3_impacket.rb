require 'package'

class Py3_impacket < Package
  description 'Impacket provides network protocols constructors and dissectors.'
  homepage 'https://www.secureauth.com/labs/open-source-tools/impacket/'
  @_ver = '0.9.23'
  version @_ver
  license 'Apache-2.0-with-impacket-modifications'
  compatibility 'all'
  source_url 'https://github.com/SecureAuthCorp/impacket.git'
  git_hashtag "impacket_#{@_ver.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.22_armv7l/py3_impacket-0.9.22-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.22_armv7l/py3_impacket-0.9.22-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.23_i686/py3_impacket-0.9.23-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.23_x86_64/py3_impacket-0.9.23-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '207d25e818e1bbeaccdfc8461459a138d109ab0542bb3576353f9e79d5b57399',
     armv7l: '207d25e818e1bbeaccdfc8461459a138d109ab0542bb3576353f9e79d5b57399',
    i686: 'bc77f9e1e7e11ccb3513bd7c95a92557c4447a15e20a4f82907348bdb5ed6fbc',
  x86_64: '85f10d35d9d2918291115d5fa418dd9059da66fc8704ae3a4ff09e2a79eb9d1b'
  })

  depends_on 'py3_pycryptodomex'
  depends_on 'py3_flask'
  depends_on 'py3_pyasn1'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_six'
  depends_on 'py3_ldap3'
  depends_on 'py3_ldapdomaindump'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
