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
    aarch64: 'ef9ce3dbe2ba6d02fa6028cd52dfd7443808f5e520e6d55c927899301cbc9912',
     armv7l: 'ef9ce3dbe2ba6d02fa6028cd52dfd7443808f5e520e6d55c927899301cbc9912',
       i686: '6596a8608080aee0579cd5a4cc33dd942a88a281435d6edf2fc05110ec5ca5bd',
     x86_64: 'ffbc9d887cdda52dbe557f1c3ce4121c54f9bd0dc495a5e9128e72a533b1cf85'
  })

  depends_on 'py3_future'
  depends_on 'py3_dnspython'
  depends_on 'py3_ldap3'
  depends_on 'python3' => :build

  no_source_build
end
