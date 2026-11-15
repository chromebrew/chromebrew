require 'buildsystems/autotools'

class Squid < Autotools
  description 'Squid Web Proxy Cache'
  homepage 'https://www.squid-cache.org/'
  version '7.7'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/squid-cache/squid.git'
  git_hashtag "SQUID_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40a5b8877f817e5e5ca6b0dc26c0ec8a4f6971121098a0a8872f86e08c69a9f7',
     armv7l: '40a5b8877f817e5e5ca6b0dc26c0ec8a4f6971121098a0a8872f86e08c69a9f7',
       i686: '210373f7ec594a153083f529f38278d416377d5d45d164c50344354dca8d36fc',
     x86_64: '2e95844190fe9195270ce6f6d548e8165fe89e174d3ccfa6a0b756396ef05e0f'
  })

  depends_on 'brotli' => :executable
  depends_on 'e2fsprogs' => :executable
  depends_on 'expat' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gmp' => :executable
  depends_on 'gnutls' => :executable
  depends_on 'krb5' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libcyrussasl' => :executable
  depends_on 'libdb' => :executable
  depends_on 'libidn2' => :executable
  depends_on 'libtasn1' => :executable
  depends_on 'libtirpc' => :executable
  depends_on 'libtool' => :executable
  depends_on 'libunistring' => :executable
  depends_on 'libxcrypt' => :executable
  depends_on 'libxml2' => :build
  depends_on 'linux_pam' => :executable
  depends_on 'nettle' => :executable
  depends_on 'openldap' => :executable
  depends_on 'openssl' => :executable
  depends_on 'p11kit' => :executable
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  # https://github.com/squid-cache/squid/pull/1118
  autotools_pre_configure_options "CXXFLAGS='-Wno-alloc-size-larger-than'"
  autotools_configure_options '--disable-arch-native --without-systemd'
end
