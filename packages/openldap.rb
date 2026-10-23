require 'buildsystems/autotools'

class Openldap < Autotools
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.7.2'
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{version}.tgz"
  source_sha256 'aad731aa22118ff327b9b4ddfc4b6f18ef9476586205da88a532e90940b523d2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '568ae13d84c19f15db50efd0948682db7d1b176680eb5e6f963e3d9645ce2262',
     armv7l: '568ae13d84c19f15db50efd0948682db7d1b176680eb5e6f963e3d9645ce2262',
       i686: 'a145c1104adf6bfa861ef38b40249408c3e1ae223a9742d1bac0663bc327f392',
     x86_64: 'da0956fc630a52980fab978b66ead4a007eb1950bf88b65cca45a53dcadc342f'
  })

  depends_on 'e2fsprogs' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'krb5' => :build
  depends_on 'libcyrussasl' => :library
  depends_on 'openssl' => :library
  depends_on 'util_linux' => :executable

  autotools_configure_options '--disable-slapd'
end
