require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '4.2.0'
  source_url 'https://ftp.gnu.org/gnu/gawk/gawk-4.2.0.tar.xz'
  source_sha256 'd4f3cd31c001fd0ed52832d4fbfbdfeaa38ad541c182f80ff8fdf87324a6a9f2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8fd6f5aef0be9a63f263c014a87116fffec221492a88fdaa8e73368a4ba65cc7',
     armv7l: '8fd6f5aef0be9a63f263c014a87116fffec221492a88fdaa8e73368a4ba65cc7',
       i686: 'd59963a75fee7fe41194ec51f3f800d3276577772152cead45f505cbaaed2ec3',
     x86_64: '24f82a456dc1322f65116b54ce83a9e657a7272639b4579d021094e19eb073c3',
  })

  depends_on 'libsigsegv'
  depends_on 'readline' => :build
  depends_on 'ncurses'
  depends_on 'mpfr'
  depends_on 'gmp'

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system 'make', 'check'
  end
end
