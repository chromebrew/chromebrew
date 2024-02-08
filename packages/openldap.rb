require 'buildsystems/autotools'

class Openldap < Autotools
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.6.7'
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url 'https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.6.7.tgz'
  source_sha256 'cd775f625c944ed78a3da18a03b03b08eea73c8aabc97b41bb336e9a10954930'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59f9ff6a7e7598580b5273c33594cc37330822e1fdeaa15c45ee6b920c804ede',
     armv7l: '59f9ff6a7e7598580b5273c33594cc37330822e1fdeaa15c45ee6b920c804ede',
       i686: 'b46d941a4a98202ecd4cc7eb383a341cffae67b0c7249ec6613928370cd24efd',
     x86_64: '5a209b3770c605c2543bb485b74d6c2c73d5724c5c6e45f448e623db1c39d107'
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
