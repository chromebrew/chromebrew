require 'buildsystems/pip'

class Py3_ldap3 < Pip
  description 'LDAP3 is a strictly RFC 4510 conforming LDAP V3 pure Python client library.'
  homepage 'https://github.com/cannatag/ldap3/'
  @_ver = '2.9.1'
  version "#{@_ver}-py3.12"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_pyasn1'
  depends_on 'python3' => :build
  no_compile_needed
end
