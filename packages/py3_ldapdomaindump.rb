require 'package'

class Py3_ldapdomaindump < Package
  description 'LDAPDomainDump uses LDAP to dump active directory information.'
  homepage 'https://github.com/dirkjanm/ldapdomaindump/'
  @_ver = '0.9.3'
  version "#{@_ver}-py3.11"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/dirkjanm/ldapdomaindump.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldapdomaindump/0.9.3-py3.11_armv7l/py3_ldapdomaindump-0.9.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldapdomaindump/0.9.3-py3.11_armv7l/py3_ldapdomaindump-0.9.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldapdomaindump/0.9.3-py3.11_i686/py3_ldapdomaindump-0.9.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldapdomaindump/0.9.3-py3.11_x86_64/py3_ldapdomaindump-0.9.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'be2f28600d9ef4d39032cd2c98b2794af9aa10e41e79cae923785a3e7f6abba4',
     armv7l: 'be2f28600d9ef4d39032cd2c98b2794af9aa10e41e79cae923785a3e7f6abba4',
       i686: 'cbc5cd4f80e9e02948057da9fbe2dd7c106d3bc0b708a7c383669a79eaf1ec64',
     x86_64: '0328a3601e032cb53d026976eee64830161e02763d3f185904ede582049e211b'
  })

  depends_on 'py3_future'
  depends_on 'py3_dnspython'
  depends_on 'py3_ldap3'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
