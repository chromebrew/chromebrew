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
    aarch64: 'cafd52bd798099d3ac521be58ed960e79ced2151f92e302e3e84b8f3f3aece59',
     armv7l: 'cafd52bd798099d3ac521be58ed960e79ced2151f92e302e3e84b8f3f3aece59',
       i686: '967f694d5344a410a6f0a41dd1f6e7d34582365a41653afdd3b895b52d0ccf7a',
     x86_64: '71f0f924559fd7ecd6f6a6e0b6853d62b48417f8c7192e7bc4d213d680de3adb'
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
