require 'buildsystems/pip'

class Py3_impacket < Pip
  description 'Impacket provides network protocols constructors and dissectors.'
  homepage 'https://www.secureauth.com/labs/open-source-tools/impacket/'
  version "0.13.1-#{CREW_PY_VER}"
  license 'Apache-2.0-with-impacket-modifications'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '189a3d646c26d6378d44cac97d608141ae2b5be1cde8b30d80613ffbeb7241aa',
     armv7l: '189a3d646c26d6378d44cac97d608141ae2b5be1cde8b30d80613ffbeb7241aa',
       i686: '77ed829ebff5adac5b9b406030a61688c70b1aef69d3d46558056e7977192845',
     x86_64: 'eb6805e84ee24ddb9adacd58fa5cdbd83d5a921a965236f477cce2b5bff23327'
  })

  depends_on 'py3_cryptography'
  depends_on 'py3_flask'
  depends_on 'py3_ldap3'
  depends_on 'py3_ldapdomaindump'
  depends_on 'py3_pyasn1'
  depends_on 'py3_pycryptodomex'
  depends_on 'py3_pyopenssl'
  depends_on 'py3_six'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
