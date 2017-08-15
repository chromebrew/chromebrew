require 'package'

class Gettext < Package
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version '0.19.8.1'
  source_url 'ftp://ftp.gnu.org/gnu/gettext/gettext-0.19.8.1.tar.xz'
  source_sha256 '105556dbc5c3fbbc2aa0edb46d22d055748b6f5c7cd7a8d99f8e7eb84e938be4'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gettext-0.19.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/gettext-0.19.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/gettext-0.19.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/gettext-0.19.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5c29d433ac66fde2b411c000eae1d5c2abbc67ae493758a85c069abcd89fe166',
     armv7l: '5c29d433ac66fde2b411c000eae1d5c2abbc67ae493758a85c069abcd89fe166',
       i686: '9302b43af04acf951c709fd1118cf95b01644013804205b3cfa78f0591d146d1',
     x86_64: '4853c8efad9bb6103ef58cdde7f07aedf794f7896d04d1919123aac04169cb98',
  })

  depends_on 'diffutils' => :build
  depends_on 'ncurses'
  depends_on 'libxml2'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
