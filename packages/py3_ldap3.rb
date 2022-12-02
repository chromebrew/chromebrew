require 'package'

class Py3_ldap3 < Package
  description 'LDAP3 is a strictly RFC 4510 conforming LDAP V3 pure Python client library.'
  homepage 'https://github.com/cannatag/ldap3/'
  @_ver = '2.9.1'
  version "#{@_ver}-py3.11"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/cannatag/ldap3.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldap3/2.9.1-py3.11_armv7l/py3_ldap3-2.9.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldap3/2.9.1-py3.11_armv7l/py3_ldap3-2.9.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldap3/2.9.1-py3.11_i686/py3_ldap3-2.9.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ldap3/2.9.1-py3.11_x86_64/py3_ldap3-2.9.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7d78b70fff525f3db374d9fa22b6f4b8218bc1f363130432e971160f5d0b29fe',
     armv7l: '7d78b70fff525f3db374d9fa22b6f4b8218bc1f363130432e971160f5d0b29fe',
       i686: '8f02546d6d2cb347e6818b93ac00b74798d4390ed76e63809baf4da2d2e700d7',
     x86_64: '2652d46da90d4896fb4982c86bc30827335ab206e384e3072d1f2beaa94203e2'
  })

  depends_on 'py3_pyasn1'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
