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
    aarch64: 'd8bb5325e395c903edeb8618df08d0ef66e7d3b06709e3826b918b3676dbf537',
     armv7l: 'd8bb5325e395c903edeb8618df08d0ef66e7d3b06709e3826b918b3676dbf537',
       i686: 'c2b276a5f1f926d5132606cd38737f327525308c50e76ead03bc54d1c64d19a1',
     x86_64: '85636fa7fe52809a39b22c2bf69783fdc6a677bbb129da387d37426e354344e0'
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
