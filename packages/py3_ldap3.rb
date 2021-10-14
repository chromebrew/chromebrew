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

  depends_on 'py3_pyasn1'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
