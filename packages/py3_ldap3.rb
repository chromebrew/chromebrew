require 'buildsystems/pip'

class Py3_ldap3 < Pip
  description 'LDAP3 is a strictly RFC 4510 conforming LDAP V3 pure Python client library.'
  homepage 'https://github.com/cannatag/ldap3/'
  version '2.9.1-py3.12'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '642203d6bec192eaffdfa0303916a5c83edc9350b7339acf469fab57dc55a2dc',
     armv7l: '642203d6bec192eaffdfa0303916a5c83edc9350b7339acf469fab57dc55a2dc',
       i686: '232dbcf9f6d2df914dc59a56bb28829b3cadbb03b816da429618c9e1568f3dfa',
     x86_64: '7e9f115c40096058bebbd6dd406a1403000fb48fab5f3ad394027fc6cac0b7d7'
  })

  depends_on 'py3_pyasn1'
  depends_on 'python3' => :build

  no_source_build
end
