require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '4.2.0'
  source_url 'https://ftp.gnu.org/gnu/gawk/gawk-4.2.0.tar.xz'
  source_sha256 'd4f3cd31c001fd0ed52832d4fbfbdfeaa38ad541c182f80ff8fdf87324a6a9f2'

  binary_url ({
  })
  binary_sha256 ({
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
