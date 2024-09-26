require 'buildsystems/pip'

class Py3_ldapdomaindump < Pip
  description 'LDAPDomainDump uses LDAP to dump active directory information.'
  homepage 'https://github.com/dirkjanm/ldapdomaindump/'
  version "0.9.4-#{CREW_PY_VER}"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0bab71e6debb44ba8122456b11cd07f37a3a05e56a4f4f7e373f2881491ec8b3',
     armv7l: '0bab71e6debb44ba8122456b11cd07f37a3a05e56a4f4f7e373f2881491ec8b3',
       i686: '47fb732975fbfeec016188075f912b96a8f2f2bd6027a568488fbb490838f558',
     x86_64: 'cdf4507be194d4f7ffd7c86869a21d329421526214cf99fe59dd9dd3f5120cf7'
  })

  depends_on 'py3_future'
  depends_on 'py3_dnspython'
  depends_on 'py3_ldap3'
  depends_on 'python3' => :build

  no_source_build
end
