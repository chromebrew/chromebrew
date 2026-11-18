require 'buildsystems/autotools'

class Libnfs < Autotools
  description 'client library for accessing NFS shares'
  homepage 'https://github.com/sahlberg/libnfs'
  version '8.0.1'
  compatibility 'all'
  license 'GPL-3, LGPL-2.1 and BSD'
  source_url 'https://github.com/sahlberg/libnfs.git'
  git_hashtag "libnfs-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd5848c2e2b184066985194cacaec8b4b15bfaf9a14044cff2fc7ea0274dadbb',
     armv7l: 'fd5848c2e2b184066985194cacaec8b4b15bfaf9a14044cff2fc7ea0274dadbb',
       i686: '110f83635a37041fdd578a367a377335a39f5e8a9d41780460b7c806a82537a0',
     x86_64: 'a489f64c01978520384abbeb9cd6c8ef7bf0d0a436befaf15d74d58138cee2ef'
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
