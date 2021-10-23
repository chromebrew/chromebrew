require 'package'

class Py3_ldapdomaindump < Package
  description 'LDAPDomainDump uses LDAP to dump active directory information.'
  homepage 'https://github.com/dirkjanm/ldapdomaindump/'
  @_ver = '0.9.3'
  version "#{@_ver}-1"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/dirkjanm/ldapdomaindump.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldapdomaindump/0.9.3-1_armv7l/py3_ldapdomaindump-0.9.3-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldapdomaindump/0.9.3-1_armv7l/py3_ldapdomaindump-0.9.3-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldapdomaindump/0.9.3-1_i686/py3_ldapdomaindump-0.9.3-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldapdomaindump/0.9.3-1_x86_64/py3_ldapdomaindump-0.9.3-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2af5b437a393130b969af08c3fea65412c1128b13a07ca56ce501c2e21bbc5cf',
     armv7l: '2af5b437a393130b969af08c3fea65412c1128b13a07ca56ce501c2e21bbc5cf',
       i686: '6e9a0b8c9feab335a855d9d8c826d2b9b3bb88c9f03f80aa3a78d3ebae7752db',
     x86_64: '4d4d54210e92ba2b736de9903d641fcc804fe6798ac40a98129774688b070477'
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
