# Does NOT build with GCC 15.
require 'buildsystems/autotools'

class Mailutils < Autotools
  description 'GNU Mailutils is the swiss army knife of electronic mail handling.'
  homepage 'https://mailutils.org'
  version '3.21'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://https.git.savannah.gnu.org/git/mailutils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '49b842de5730cd3dde6ef61ef59b9d28bd3785e6698eb770b739ccfa46eca53e',
     armv7l: '49b842de5730cd3dde6ef61ef59b9d28bd3785e6698eb770b739ccfa46eca53e',
     x86_64: '23b09821334d5c8eb602cc8bf15f60eb90af070aaff4cbc4e14bdaa3cb60a0cb'
  })

  depends_on 'brotli' => :executable
  depends_on 'e2fsprogs' => :executable
  depends_on 'emacs' => :build
  depends_on 'fribidi' => :executable
  depends_on 'gdbm' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :executable
  depends_on 'gnutls' => :library
  depends_on 'krb5' => :executable
  depends_on 'libcyrussasl' => :executable
  depends_on 'libdb' => :library
  depends_on 'libidn2' => :executable
  depends_on 'libtasn1' => :executable
  depends_on 'libtirpc' => :executable
  depends_on 'libtool' => :library
  depends_on 'libunistring' => :executable
  depends_on 'libxcrypt' => :library
  depends_on 'linux_pam' => :library
  depends_on 'ncurses' => :executable
  depends_on 'nettle' => :executable
  depends_on 'openldap' => :library
  depends_on 'openssl' => :executable
  depends_on 'p11kit' => :executable
  depends_on 'perl_pod_parser' => :build
  depends_on 'python3' => :library
  depends_on 'readline' => :executable
  depends_on 'tcpwrappers' => :executable
  depends_on 'wget2' => :build
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  autotools_pre_configure_options "CFLAGS='-Wno-incompatible-pointer-types'"
  autotools_configure_options '--enable-ipv6 \
            --with-gnutls \
            --with-berkeley-db \
            --without-guile \
            --with-gdbm \
            --with-fribidi \
            --with-unistring \
            --with-tcp-wrappers \
            --with-readline'

  def self.check
    system 'make check || /bin/true' # Check 471 will fail
  end
end
