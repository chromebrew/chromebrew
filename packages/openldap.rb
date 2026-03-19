require 'buildsystems/autotools'

class Openldap < Autotools
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.6.13'
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{version}.tgz"
  source_sha256 'd693b49517a42efb85a1a364a310aed16a53d428d1b46c0d31ef3fba78fcb656'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe4526b9055e9ff1ed965577a1bdb7a83ce24ad272b7e758de054ab5ea2b23ea',
     armv7l: 'fe4526b9055e9ff1ed965577a1bdb7a83ce24ad272b7e758de054ab5ea2b23ea',
       i686: '4589122bcceabc92e4669330dbfe83a16cabeaf9879433a2fa665a7da5514e1a',
     x86_64: '88540a9db9c707ae0f320400ab54b6262a5b9bce5e9468a5140f29a3bc335288'
  })

  depends_on 'e2fsprogs' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'krb5' => :build
  depends_on 'libcyrussasl' # R
  depends_on 'openssl' # R
  depends_on 'util_linux' => :executable

  autotools_configure_options '--disable-slapd'
end
