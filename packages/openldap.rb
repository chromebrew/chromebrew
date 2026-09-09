require 'buildsystems/autotools'

class Openldap < Autotools
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.7.1'
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{version}.tgz"
  source_sha256 '253db80f301258ea69cda1184766d57395b836aaabf41157eb0316eb0fac1341'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b2065c5cb17100c907fa0b1eb0306839d9842f0470f98c3daa520b46471512ec',
     armv7l: 'b2065c5cb17100c907fa0b1eb0306839d9842f0470f98c3daa520b46471512ec',
       i686: '822f344a7c9a9ea77ac5416c01b212906aea19f87db184df295e73c9fc1111cb',
     x86_64: '28dfa009d871a30391437c108adfa0e3b7197b4c91333de94e8ccae79233eb13'
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
