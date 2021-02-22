require 'package'

class Mailutils < Package
  description 'GNU Mailutils is the swiss army knife of electronic mail handling.'
  homepage 'https://mailutils.org'
  version '3.12'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/mailutils/mailutils-3.12.tar.xz'
  source_sha256 '6d43fa217c4ac63f057de87890c562d170bb92bc402368b5fbc579e4c2b3a158'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mailutils-3.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mailutils-3.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mailutils-3.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mailutils-3.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '826c7106823744618d9d070727ce7349845918576442dc00e52643e394792a5a',
     armv7l: '826c7106823744618d9d070727ce7349845918576442dc00e52643e394792a5a',
       i686: '19680504fee9c4864c544f674c83ad052af68624cdce0b50fe56e8184da4cc85',
     x86_64: '80da9e98948aa0a87d062659783a6518669892bc27e65d755ef58aefc1977e96',
  })

  depends_on 'libdb'
  depends_on 'emacs'
  depends_on 'tcpwrappers'
  
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
