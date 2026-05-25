require 'buildsystems/autotools'

class Libnfs < Autotools
  description 'client library for accessing NFS shares'
  homepage 'https://github.com/sahlberg/libnfs'
  version '6.0.2'
  compatibility 'all'
  license 'GPL-3, LGPL-2.1 and BSD'
  source_url 'https://github.com/sahlberg/libnfs.git'
  git_hashtag "libnfs-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6767c33c704f4240a9ad5a72c656f491696f7ff54a40ffc22adef5302ef1ddde',
     armv7l: '6767c33c704f4240a9ad5a72c656f491696f7ff54a40ffc22adef5302ef1ddde',
       i686: '6883e2ab1e6b20dc688eb5b4e000407d19e7f9738c9aba8d344d9af48a41a620',
     x86_64: '28e4008977ca30b2bc74c8cdec9ca5cdc9933aa998da8f62a2b343ab9a0517a3'
  })

  depends_on 'brotli' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :executable
  depends_on 'gnutls' => :executable
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
