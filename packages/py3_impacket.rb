require 'buildsystems/pip'

class Py3_impacket < Pip
  description 'Impacket provides network protocols constructors and dissectors.'
  homepage 'https://www.secureauth.com/labs/open-source-tools/impacket/'
  version "0.12.0-#{CREW_PY_VER}"
  license 'Apache-2.0-with-impacket-modifications'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '934f48a9f70caa18993c8c76447e1d73cdf4f985fa4e4ee68569c5eaf4b648bc',
     armv7l: '934f48a9f70caa18993c8c76447e1d73cdf4f985fa4e4ee68569c5eaf4b648bc',
       i686: 'c04bebbfe77b9f36d322a89a5000e7e169e332d4b05921607fa2d31b43b21077',
     x86_64: '7c046d13fb35a460a96a142b1da980c2bdf0892d1e09b06af02bdbff5e7975d4'
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
