require 'buildsystems/autotools'

class Openldap < Autotools
  description 'OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol.'
  homepage 'https://www.openldap.org/'
  version '2.6.10'
  license 'OpenLDAP and GPL-2'
  compatibility 'all'
  source_url "https://openldap.org/software/download/OpenLDAP/openldap-release/openldap-#{version}.tgz"
  source_sha256 '2cb7dc73e9c8340dff0d99357fbaa578abf30cc6619f0521972c555681e6b2ff'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f48ecd71d964e7c422a5f06a602c3ea49545dffa774fe4cfb89bb5d475a5490d',
     armv7l: 'f48ecd71d964e7c422a5f06a602c3ea49545dffa774fe4cfb89bb5d475a5490d',
       i686: 'db013c7fe3e73cd8ae0dabf876d5146dbb7c5438cdd1e9bff56f8d211f792d6c',
     x86_64: '40578ae19ead9a8ccba67cad00b278bc3bef87a08cd4e075ba6cdcac51eba290'
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
