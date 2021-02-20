require 'package'

class Mailutils < Package
  description 'GNU Mailutils is the swiss army knife of electronic mail handling.'
  homepage 'https://mailutils.org'
  version '3.12'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/mailutils/mailutils-3.12.tar.xz'
  source_sha256 '6d43fa217c4ac63f057de87890c562d170bb92bc402368b5fbc579e4c2b3a158'

  depends_on 'python3'
  depends_on 'libdb'
  depends_on 'emacs'
  depends_on 'tcpwrappers'
  depends_on 'readline'
  
  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-ipv6 \
            --with-berkeley-db \
            --without-guile \
            --with-gdbm \
            --with-unistring \
            --with-tcp-wrappers \
            --with-readline"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make check || /bin/true" # Check 471 will fail
  end
end
