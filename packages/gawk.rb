require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '4.1.4-1'
  source_url 'http://ftp.gnu.org/gnu/gawk/gawk-4.1.4.tar.xz'
  source_sha1 'd67e00e2f6178e9cbd2c0ba923ae157bc0b3b570'

  depends_on 'libsigsegv'
  depends_on 'readline' => :build
  depends_on 'ncurses'
  depends_on 'mpfr'
  depends_on 'gmp'

  def self.build
    system './configure', '--prefix=/usr/local'
    system 'make'
    system "find . -name '*.so' -print | xargs strip -S"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system 'make', 'check'
  end
end
