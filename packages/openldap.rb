require 'buildsystems/autotools'

class Openldap < Autotools
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.6.8'
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url 'https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.6.8.tgz'
  source_sha256 '48969323e94e3be3b03c6a132942dcba7ef8d545f2ad35401709019f696c3c4e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b475001d98c3143a48c57887a26fe2366149061c6dfeb6b26aa84fc2179a6cd',
     armv7l: '3b475001d98c3143a48c57887a26fe2366149061c6dfeb6b26aa84fc2179a6cd',
       i686: '86d7876872980466fd29a2f0fa94b1f2f08d7d9c99e72f74df30e6df0caa7a86',
     x86_64: 'c60b1a431470cdef4b61b2cfbd16d512541a95e83a447f90327f5da03c7b6414'
  })

  depends_on 'e2fsprogs' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'krb5' => :build
  depends_on 'libcyrussasl' # R
  depends_on 'openssl' # R
  depends_on 'util_linux' # R

  configure_options '--disable-slapd'
end
