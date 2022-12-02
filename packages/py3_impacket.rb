require 'package'

class Py3_impacket < Package
  description 'Impacket provides network protocols constructors and dissectors.'
  homepage 'https://www.secureauth.com/labs/open-source-tools/impacket/'
  @_ver = '0.9.23'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0-with-impacket-modifications'
  compatibility 'all'
  source_url 'https://github.com/SecureAuthCorp/impacket.git'
  git_hashtag "impacket_#{@_ver.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.23-py3.11_armv7l/py3_impacket-0.9.23-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.23-py3.11_armv7l/py3_impacket-0.9.23-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.23-py3.11_i686/py3_impacket-0.9.23-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.23-py3.11_x86_64/py3_impacket-0.9.23-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0d1adf5517d4f9350a737b13b0a5a2900678a2e61f0c61519bd05d25254330dc',
     armv7l: '0d1adf5517d4f9350a737b13b0a5a2900678a2e61f0c61519bd05d25254330dc',
       i686: '1679752d49579579759fcb9d0fcc9b99f41583c1224e5a918824e91620a4d52e',
     x86_64: 'f1047f6f18bdbf5063c09e1a6103bcb8b70b935d33ba5dc43d7a987d34e86467'
  })

  depends_on 'py3_pycryptodomex'
  depends_on 'py3_flask'
  depends_on 'py3_pyasn1'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_six'
  depends_on 'py3_ldap3'
  depends_on 'py3_ldapdomaindump'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
