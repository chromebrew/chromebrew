require 'buildsystems/pip'

class Py3_ldap3 < Pip
  description 'LDAP3 is a strictly RFC 4510 conforming LDAP V3 pure Python client library.'
  homepage 'https://github.com/cannatag/ldap3/'
  version "2.9.1-#{CREW_PY_VER}"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3cdf77fb19eb04a8cbaed5b623ae45762c0663939c6528711cfa19070bae8dd3',
     armv7l: '3cdf77fb19eb04a8cbaed5b623ae45762c0663939c6528711cfa19070bae8dd3',
       i686: 'ad6172927643ddb11828a4e6e5384f7303bbda14b80f837e87ffb642f20e1dd8',
     x86_64: '790978ce38b8e1e7f18fac1915520edd83c2e93eab0120238feac7cf6145bea0'
  })

  depends_on 'py3_pyasn1'
  depends_on 'python3' => :build

  no_source_build
end
