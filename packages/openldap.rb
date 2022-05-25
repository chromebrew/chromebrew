require 'buildsystems/autotools'

class Openldap < Autotools
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.6.6'
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{version}.tgz"
  source_sha256 '082e998cf542984d43634442dbe11da860759e510907152ea579bdc42fe39ea0'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.6_armv7l/openldap-2.6.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.6_armv7l/openldap-2.6.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.6_i686/openldap-2.6.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openldap/2.6.6_x86_64/openldap-2.6.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1e48b2d0f8b5a575222271b57006c2281c0a392d63fd3dedf84d9ce33371a27c',
     armv7l: '1e48b2d0f8b5a575222271b57006c2281c0a392d63fd3dedf84d9ce33371a27c',
       i686: 'dabfadedd28a9db659eda4457722a9112e19e0093384cbfd06db049cd33bb6b5',
     x86_64: 'a5a93d727f0fd0c7840d5d133801f336b5833a12c59dbcf1867451b627a931be'
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
