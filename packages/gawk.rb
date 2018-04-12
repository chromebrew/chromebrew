require 'package'

class Gawk < Package
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '4.2.1'
  source_url 'https://ftpmirror.gnu.org/gawk/gawk-4.2.1.tar.gz'
  source_sha256 '2b23d51503b2df9a41aa6fddc6002ad7ebf2a386ac19dc1b6be0dd48b0acf6db'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gawk-4.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8a9bcb6324601c08e562c2a05b9986a4124922a666474ac9419aa144f21dda63',
     armv7l: '8a9bcb6324601c08e562c2a05b9986a4124922a666474ac9419aa144f21dda63',
       i686: '30522a5f3d71d4c8189d7ff2b10e09bcf0209e87f5b92ac0ecde62324c7776ff',
     x86_64: '64faab8c251933f07df9b6dbfacad9983dafdb831168e6dc912a38cfdae4af41',
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
