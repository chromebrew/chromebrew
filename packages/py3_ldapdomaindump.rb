require 'package'

class Py3_ldapdomaindump < Package
  description 'LDAPDomainDump uses LDAP to dump active directory information.'
  homepage 'https://github.com/dirkjanm/ldapdomaindump/'
  @_ver = '0.9.3'
  version @_ver
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/dirkjanm/ldapdomaindump.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldapdomaindump/0.9.3_armv7l/py3_ldapdomaindump-0.9.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldapdomaindump/0.9.3_armv7l/py3_ldapdomaindump-0.9.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldapdomaindump/0.9.3_x86_64/py3_ldapdomaindump-0.9.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8863611b54e966831c4adf1901cbbc8911cd09fffde4039ccf696b70bb9d3098',
     armv7l: '8863611b54e966831c4adf1901cbbc8911cd09fffde4039ccf696b70bb9d3098',
     x86_64: '90d80b5305990db7a424673c1dfc380f9eb16dec7f04c87f6184e399b8822b1e'
  })

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
