require 'buildsystems/autotools'

class Squid < Autotools
  description 'Squid Web Proxy Cache'
  homepage 'https://www.squid-cache.org/'
  version '6.8'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/squid-cache/squid.git'
  git_hashtag 'SQUID_6_8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f24eec890e52e5f3cb3bad3e0496d8947158427ba770a97144acf4965277699',
     armv7l: '3f24eec890e52e5f3cb3bad3e0496d8947158427ba770a97144acf4965277699',
       i686: '09b29eb0a306d5e1b99b320b2994228fa06b83e4889744d579d07ca63027c85e',
     x86_64: '99550be07e2e0b426fa29a2ee3cf84127241022509c54b449151ae9755ca0e8a'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc_lib' # R
  depends_on 'gnutls' # R
  depends_on 'krb5' # R
  depends_on 'libcap' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libdb' # R
  depends_on 'libtool' # R
  depends_on 'libxml2' # R
  depends_on 'linux_pam' # R
  depends_on 'nettle' # R
  depends_on 'openldap' # R
  depends_on 'glibc' # R

  # https://github.com/squid-cache/squid/pull/1118
  pre_configure_options "CXXFLAGS='-Wno-alloc-size-larger-than'"
  configure_options '--disable-arch-native --without-systemd'
end
