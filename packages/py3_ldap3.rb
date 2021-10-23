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
    aarch64: '09d3423dc4e0bc974fdfc2ddf0d1a1afb7a48c6b90a158d4e5b238b716e9eaa8',
     armv7l: '09d3423dc4e0bc974fdfc2ddf0d1a1afb7a48c6b90a158d4e5b238b716e9eaa8',
       i686: '5fedce99e0812364a4bdc5f229c181be448d97699d5b5a4fb188109ef1d04031',
     x86_64: 'd2aff57b5e0d631fb69b08ad42d6fc06dd1ede84f784902fc08f92bb60826cb6'
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
