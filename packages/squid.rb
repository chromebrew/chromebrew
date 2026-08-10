require 'buildsystems/autotools'

class Squid < Autotools
  description 'Squid Web Proxy Cache'
  homepage 'https://www.squid-cache.org/'
  version '7.6'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/squid-cache/squid.git'
  git_hashtag "SQUID_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11d80c1fadffaebd5566e0c06016e4d8339eda1a8ec892faa9e98f5c2d2f58e0',
     armv7l: '11d80c1fadffaebd5566e0c06016e4d8339eda1a8ec892faa9e98f5c2d2f58e0',
       i686: 'c5d5b0c40bfb7aa5c2fae55763591fb8049aa598853fd388603e325307bb17dc',
     x86_64: '7746a33a08bb292dc9971460ad5da1ef3568c527558bd806d17d27d6d1c268e5'
  })

  depends_on 'brotli' => :executable
  depends_on 'e2fsprogs' => :library
  depends_on 'expat' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :executable
  depends_on 'gnutls' => :executable
  depends_on 'krb5' => :library
  depends_on 'libcap' => :executable
  depends_on 'libcyrussasl' => :library
  depends_on 'libdb' => :library
  depends_on 'libidn2' => :executable
  depends_on 'libtasn1' => :executable
  depends_on 'libtirpc' => :library
  depends_on 'libtool' => :executable
  depends_on 'libunistring' => :executable
  depends_on 'libxcrypt' => :library
  depends_on 'libxml2' => :library
  depends_on 'linux_pam' => :library
  depends_on 'nettle' => :library
  depends_on 'openldap' => :library
  depends_on 'openssl' => :library
  depends_on 'p11kit' => :executable
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  # https://github.com/squid-cache/squid/pull/1118
  autotools_pre_configure_options "CXXFLAGS='-Wno-alloc-size-larger-than'"
  autotools_configure_options '--disable-arch-native --without-systemd'
end
