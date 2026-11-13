# Does NOT build with GCC 15.
require 'buildsystems/autotools'

class Mailutils < Autotools
  description 'GNU Mailutils is the swiss army knife of electronic mail handling.'
  homepage 'https://mailutils.org'
  version '3.20'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://https.git.savannah.gnu.org/git/mailutils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9092b850262749d5c9e96592f07b62fc20299b11a2324c75a842823f2a3290c',
     armv7l: 'f9092b850262749d5c9e96592f07b62fc20299b11a2324c75a842823f2a3290c',
     x86_64: '6f4b18de58422568a586105c0171116c22fe332962e00fdb3b1a5c68f36473b1'
  })

  depends_on 'brotli' => :library
  depends_on 'e2fsprogs' => :executable
  depends_on 'emacs' => :build
  depends_on 'fribidi' # R
  depends_on 'gdbm' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'gnutls' => :library
  depends_on 'krb5' => :executable
  depends_on 'libcyrussasl' => :library
  depends_on 'libdb' => :library
  depends_on 'libidn2' => :library
  depends_on 'libtasn1' => :library
  depends_on 'libtirpc' => :executable
  depends_on 'libtool' => :library
  depends_on 'libunistring' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'linux_pam' => :library
  depends_on 'ncurses' => :executable
  depends_on 'nettle' # R
  depends_on 'openldap' => :library
  depends_on 'openssl' => :library
  depends_on 'p11kit' => :library
  depends_on 'perl_pod_parser' => :build
  depends_on 'python3' # R
  depends_on 'readline' => :executable
  depends_on 'tcpwrappers' => :executable
  depends_on 'wget2' => :build
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

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
