require 'package'

class Py3_ldap3 < Package
  description 'LDAP3 is a strictly RFC 4510 conforming LDAP V3 pure Python client library.'
  homepage 'https://github.com/cannatag/ldap3/'
  @_ver = '2.9.1'
  version @_ver
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/cannatag/ldap3.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldap3/2.9.1_armv7l/py3_ldap3-2.9.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldap3/2.9.1_armv7l/py3_ldap3-2.9.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldap3/2.9.1_i686/py3_ldap3-2.9.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldap3/2.9.1_x86_64/py3_ldap3-2.9.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dc7919d10be71fd2fe4b8947a406507eefa5b1d451df185c01a65d4d782fea67',
     armv7l: 'dc7919d10be71fd2fe4b8947a406507eefa5b1d451df185c01a65d4d782fea67',
       i686: 'e6e147db62d2363d75a301517de9abc637bada7826ccbf7231f6b3f7f87aaa13',
     x86_64: '6d317338004c117385ba585f614070bbaf65eeadff449b662682228d22115dd3'
  })

  depends_on 'py3_pyasn1'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
