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
    aarch64: '2c1bbc2d3813eff21b4217614ca98606234e123dc930f52a05425d4ddf7ee253',
     armv7l: '2c1bbc2d3813eff21b4217614ca98606234e123dc930f52a05425d4ddf7ee253',
       i686: '93f8bbc137ffd9a26cfa9f694de720f0007b82084cd9b8c945cc743992f9be8c',
     x86_64: 'ad274a4893be58b67d62438d2c02f77adb928f48e8e099e15e9b21f732a10bf0'
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
