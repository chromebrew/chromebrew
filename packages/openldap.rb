require 'buildsystems/autotools'

class Openldap < Autotools
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.6.12'
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{version}.tgz"
  source_sha256 '1716ad779e85d743694c3e3b05277fb71b6a5eadca43c7a958aa62683b22208e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9abf23887c4ea133215d9f83b2447488697f2971e298fadf8bcb3477f5eba8e3',
     armv7l: '9abf23887c4ea133215d9f83b2447488697f2971e298fadf8bcb3477f5eba8e3',
       i686: 'dac0a391b2cfe0b1850b0436f2e9ae4678950b1723c95141938f2b7092e1d269',
     x86_64: '8385c9826391f34c25374d01ca24f53fad4e3f1fdf15e00eebe644760b3d607c'
  })

  depends_on 'e2fsprogs' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'krb5' => :build
  depends_on 'libcyrussasl' # R
  depends_on 'openssl' # R
  depends_on 'util_linux' # R

  autotools_configure_options '--disable-slapd'
end
