require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '5.1.0'
  source_url 'https://ftpmirror.gnu.org/gawk/gawk-5.1.0.tar.lz'
  source_sha256 '8a13d0adfacde9540acbb2e0ad9867ef17890b3fd4c2af288fe3c4f7b507a274'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-5.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-5.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-5.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-5.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7539039d47859d047cae70909b10399edeb8c83987701f98fbaa33ceb0b842ce',
     armv7l: '7539039d47859d047cae70909b10399edeb8c83987701f98fbaa33ceb0b842ce',
       i686: 'dbb287568e17ca77270f031b5b508065f81558a65d59317016f2fab2164ee2dc',
     x86_64: '7e9fe04d828af1854af814c2980e370b99814effd2ecdd01bdd673416216d777',
  })

  depends_on 'libsigsegv'
  depends_on 'readline' => :build
  depends_on 'ncurses'
  depends_on 'mpfr'
  depends_on 'gmp'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
