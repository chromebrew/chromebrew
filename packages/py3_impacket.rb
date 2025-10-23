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
       i686: '02b9b7078071ebcfd41ec380ce9840130db8ec937ab09d538f81e3794f6bbe09',
     x86_64: '557cd4f333f907645c46155ed292b2f9ff61c58df983e1a36c5afa6c6d408322'
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
