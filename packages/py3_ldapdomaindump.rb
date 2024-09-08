require 'buildsystems/pip'

class Py3_ldapdomaindump < Pip
  description 'LDAPDomainDump uses LDAP to dump active directory information.'
  homepage 'https://github.com/dirkjanm/ldapdomaindump/'
  version '0.9.4-py3.12'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_future'
  depends_on 'py3_dnspython'
  depends_on 'py3_ldap3'
  depends_on 'python3' => :build

  no_compile_needed
end
