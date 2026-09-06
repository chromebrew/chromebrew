require 'buildsystems/autotools'

class Libnfs < Autotools
  description 'client library for accessing NFS shares'
  homepage 'https://github.com/sahlberg/libnfs'
  version '7.0.2'
  compatibility 'all'
  license 'GPL-3, LGPL-2.1 and BSD'
  source_url 'https://github.com/sahlberg/libnfs.git'
  git_hashtag "libnfs-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67c93cf5476247f06164d3115aa0533e735c72fef44c0fb6f4a2065258fd233e',
     armv7l: '67c93cf5476247f06164d3115aa0533e735c72fef44c0fb6f4a2065258fd233e',
       i686: 'ad1fbddbc79ea250921ad58f1dc8baeecdbbbbca8f1f2f3984c8251012698d8d',
     x86_64: 'c6fd9f206b3ca76970f4e5f0800c037c1e1a062ae86e5acb3472ea8874757e81'
  })

  depends_on 'brotli' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :executable
  depends_on 'gnutls' => :executable
  depends_on 'gnutls' => :library
  depends_on 'krb5' => :library
  depends_on 'libidn2' => :executable
  depends_on 'libtasn1' => :executable
  depends_on 'libunistring' => :executable
  depends_on 'nettle' => :executable
  depends_on 'p11kit' => :executable
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  autotools_configure_options '--enable-utils'
  autotools_pre_configure_options ('CFLAGS="$CFLAGS -Wno-cast-align"' if ARCH.include?('armv7l')).to_s
end
