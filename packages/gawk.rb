require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '4.1.4-1'
  source_url 'http://ftp.gnu.org/gnu/gawk/gawk-4.1.4.tar.xz'
  source_sha256 '53e184e2d0f90def9207860531802456322be091c7b48f23fdc79cda65adc266'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.1.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.1.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.1.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.1.4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c2ced685d98ec85de68b5eac56c6d297619502b3bee290145abfe9d35a52d960',
     armv7l: 'c2ced685d98ec85de68b5eac56c6d297619502b3bee290145abfe9d35a52d960',
       i686: '1c032e90b3ee55a7a916a7d6e36e9accaa21926ef9c6099ebb289330320ecfce',
     x86_64: '61eb233ff9bc2f0f23e3b169bfaa0ed1dd4abcc92583a26aaf0e287905fa7d82',
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
