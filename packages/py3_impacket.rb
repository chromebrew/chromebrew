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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.23_armv7l/py3_impacket-0.9.23-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.23_armv7l/py3_impacket-0.9.23-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.23_i686/py3_impacket-0.9.23-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_impacket/0.9.23_x86_64/py3_impacket-0.9.23-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c37b27ae6b0b5c58abdadc9a25f0652e2edc00ec4539f7fd1ccc53e2de25b589',
     armv7l: 'c37b27ae6b0b5c58abdadc9a25f0652e2edc00ec4539f7fd1ccc53e2de25b589',
       i686: '17387538bc0ce405a19ee9a02dd0edf138ccc80bc663d32493448b36de9a479e',
     x86_64: '353624e76228604e37d2ade33876f9bd9b098dd06c9e776df00a2ee7f74c6bcf'
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
