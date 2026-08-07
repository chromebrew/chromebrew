require 'buildsystems/autotools'

class Openldap < Autotools
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.7.0'
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{version}.tgz"
  source_sha256 '9e86f37da375aa948a1b478dd76fe87b02090e47c21facae19223588e3407922'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23111e9e9e603f2ec9c3ca7715d0ad21a9b555010312fb86f4a1325dad05892a',
     armv7l: '23111e9e9e603f2ec9c3ca7715d0ad21a9b555010312fb86f4a1325dad05892a',
       i686: 'ead9991dda6aa6cc54ca85abe8f92f6b083c562cf362d0d1544f4a0d657039e4',
     x86_64: '4a04743fddcf7c28a7fa4e56a549022a2b5862a67d692f3c51f302b31883caa0'
  })

  depends_on 'e2fsprogs' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'krb5' => :build
  depends_on 'libcyrussasl' => :library
  depends_on 'openssl' => :library
  depends_on 'util_linux' => :executable

  autotools_configure_options '--disable-slapd'
end
