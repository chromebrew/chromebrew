require 'package'

class Py3_impacket < Package
  description 'Impacket provides network protocols constructors and dissectors.'
  homepage 'https://www.secureauth.com/labs/open-source-tools/impacket/'
  @_ver = '0.9.22'
  version @_ver
  license 'Apache-2.0-with-impacket-modifications'
  compatibility 'all'
  source_url 'https://github.com/SecureAuthCorp/impacket.git'
  git_hashtag 'impacket_' + @_ver.gsub('.', '_')

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
