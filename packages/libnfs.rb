require 'buildsystems/autotools'

class Libnfs < Autotools
  description 'client library for accessing NFS shares'
  homepage 'https://github.com/sahlberg/libnfs'
  version '7.0.0'
  compatibility 'all'
  license 'GPL-3, LGPL-2.1 and BSD'
  source_url 'https://github.com/sahlberg/libnfs.git'
  git_hashtag "libnfs-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2bd67f4739647c15fc2b9fd2f08230be3664683280c6c97e584cec4ffddba4bf',
     armv7l: '2bd67f4739647c15fc2b9fd2f08230be3664683280c6c97e584cec4ffddba4bf',
       i686: '3bdb89b3e2e98d35c2d0f32a7ad078995b01c406fa74be0a704047b4200e0784',
     x86_64: '8d00f59210d43f42c913624d232bca019a1ebfcf40488afee044c3e3e59e01de'
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
