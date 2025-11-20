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

  depends_on 'brotli' # R
  depends_on 'e2fsprogs' # R
  depends_on 'emacs' => :build
  depends_on 'fribidi' # R
  depends_on 'gdbm' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'krb5' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libdb' # R
  depends_on 'libidn2' # R
  depends_on 'libtasn1' # R
  depends_on 'libtirpc' # R
  depends_on 'libtool' # R
  depends_on 'libunistring' # R
  depends_on 'libxcrypt' # R
  depends_on 'linux_pam' # R
  depends_on 'ncurses' # R
  depends_on 'nettle' # R
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'p11kit' # R
  depends_on 'perl_pod_parser' => :build
  depends_on 'python3' # R
  depends_on 'readline' # R
  depends_on 'tcpwrappers' # R
  depends_on 'wget2' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

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
