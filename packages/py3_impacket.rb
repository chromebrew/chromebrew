require 'buildsystems/pip'

class Py3_impacket < Pip
  description 'Impacket provides network protocols constructors and dissectors.'
  homepage 'https://www.secureauth.com/labs/open-source-tools/impacket/'
  version "0.13.0-#{CREW_PY_VER}"
  license 'Apache-2.0-with-impacket-modifications'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74a9010114ab00f4284779fbd7e8167081713738a533a75505f02e9952baca86',
     armv7l: '74a9010114ab00f4284779fbd7e8167081713738a533a75505f02e9952baca86',
       i686: '8af047d0acfe121e4851f6da2be737df2039a1cc12255db4b95543c6c57dcc66',
     x86_64: '02ea1096d99a8707bad27c53605f925e9730ce4b2c55be3dbf96eb0c2c9bcaf7'
  })

  depends_on 'py3_pycryptodomex'
  depends_on 'py3_cryptography'
  depends_on 'py3_flask'
  depends_on 'py3_pyasn1'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_six'
  depends_on 'py3_ldap3'
  depends_on 'py3_ldapdomaindump'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
