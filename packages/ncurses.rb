require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.1'
  source_url 'https://ftpmirror.gnu.org/ncurses/ncurses-6.1.tar.gz'
  source_sha256 'aa057eeeb4a14d470101eff4597d5833dcef5965331be3528c08d99cebaa0d17'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4e33d4fc68ea5b47bae07aa710b1f801fd80ba85a02c0060c6f157100acadaf4',
     armv7l: '4e33d4fc68ea5b47bae07aa710b1f801fd80ba85a02c0060c6f157100acadaf4',
       i686: '16a5f5c03a4e9591146dc56a1ed4b017c09ad9d72da38d104ce282a3d25ef9fd',
     x86_64: '1eab39eee49e16799ad61def29e69c50a7ea39b04a8da2ff4f4ada033e81273c',
  })

  depends_on 'diffutils' => :build
  depends_on 'ncursesw'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-normal',
           '--with-shared',
           '--with-cxx-shared',
           '--without-debug'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
