require 'buildsystems/pip'

class Py3_ldapdomaindump < Pip
  description 'LDAPDomainDump uses LDAP to dump active directory information.'
  homepage 'https://github.com/dirkjanm/ldapdomaindump/'
  version "0.10.0-#{CREW_PY_VER}"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '30333d359732b713561e25f97c7c1145daada5601a3307d76df4b106419d42fc',
     armv7l: '30333d359732b713561e25f97c7c1145daada5601a3307d76df4b106419d42fc',
       i686: '7a1169e62aa0f77e1238866a743a20e118340d4e6dd6b3a5ffd59c6017893deb',
     x86_64: '2e590e1041a1b43aa4bb6caa372851307b55408e9ab4ca7d2d26f16240e8a26e'
  })

  depends_on 'py3_future'
  depends_on 'py3_dnspython'
  depends_on 'py3_ldap3'
  depends_on 'python3' => :build

  no_source_build
end
