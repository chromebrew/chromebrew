require 'package'

class Py3_ldapdomaindump < Package
  description 'LDAPDomainDump uses LDAP to dump active directory information.'
  homepage 'https://github.com/dirkjanm/ldapdomaindump/'
  @_ver = '0.9.3'
  version @_ver
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/dirkjanm/ldapdomaindump.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_future'
  depends_on 'py3_dnspython'
  depends_on 'py3_ldap3'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
