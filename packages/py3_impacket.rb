require 'buildsystems/pip'

class Py3_impacket < Pip
  description 'Impacket provides network protocols constructors and dissectors.'
  homepage 'https://www.secureauth.com/labs/open-source-tools/impacket/'
  version '0.11.0-py3.12'
  license 'Apache-2.0-with-impacket-modifications'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa8591cf4bb65c1690c9e47d7d19443916697c073c3ab07f1993997ea112b604',
     armv7l: 'aa8591cf4bb65c1690c9e47d7d19443916697c073c3ab07f1993997ea112b604',
       i686: '8b7d70465846f4c0a0c84d338a32bcb9c6e1b00f67fe83bbe231b0e9b961ca8e',
     x86_64: 'ea69014fbf63f98390a229dee574c0ff58d6ea209b24d32c11d8d0dec9b42869'
  })

  depends_on 'py3_pycryptodomex'
  depends_on 'py3_flask'
  depends_on 'py3_pyasn1'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_six'
  depends_on 'py3_ldap3'
  depends_on 'py3_ldapdomaindump'
  depends_on 'python3' => :build

  no_source_build
end
