require 'package'

class Py3_ldap3 < Package
  description 'LDAP3 is a strictly RFC 4510 conforming LDAP V3 pure Python client library.'
  homepage 'https://github.com/cannatag/ldap3/'
  @_ver = '2.9'
  version @_ver
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/cannatag/ldap3.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldap3/2.9_armv7l/py3_ldap3-2.9-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldap3/2.9_armv7l/py3_ldap3-2.9-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldap3/2.9_x86_64/py3_ldap3-2.9-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '40e23ad500cdfc66f8f67a651ed07276fbe9ecf3ca4440f3a02016cf7b670fdb',
     armv7l: '40e23ad500cdfc66f8f67a651ed07276fbe9ecf3ca4440f3a02016cf7b670fdb',
     x86_64: 'd5bdd0be697e51fe7919bb4c485791b1cdd3f517b027e8b2c7ba4e8aca97ec86'
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
