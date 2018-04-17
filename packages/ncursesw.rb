require 'package'

class Ncursesw < Package
  description 'ncurses wide-character libraries.'
  homepage 'http://www.gnu.org/software/ncurses/'
  version '6.1'
  source_url 'https://ftpmirror.gnu.org/ncurses/ncurses-6.1.tar.gz'
  source_sha256 'aa057eeeb4a14d470101eff4597d5833dcef5965331be3528c08d99cebaa0d17'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ncursesw-6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ncursesw-6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ncursesw-6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncursesw-6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '78f2dd654bfe65e29b43109d4ba4551337af6546e8a0b3d74cb5f4dfe93d0a38',
     armv7l: '78f2dd654bfe65e29b43109d4ba4551337af6546e8a0b3d74cb5f4dfe93d0a38',
       i686: '2287e7bab7b63649624132265cb2f33477703ae8ee754a866f13e4bf66b71ea5',
     x86_64: 'a2542e59a79bd82178b29ac96af4dc53cabc73bad7faca3ea8f5bb2afc99f5aa',
  })

  depends_on 'diffutils' => :build

  def self.build
    # Check ncurses doesn't conflict with ncrusesw
    if File.exist? CREW_CONFIG_PATH + "meta/ncurses.filelist"
      if `grep include/ncursesw #{CREW_CONFIG_PATH}meta/ncurses.filelist` != ''
        puts
        puts "PLEASE PERFORM `crew upgrade ncurses` OR `crew remove ncurses` FIRST"
        puts
        exit 1
      end
    end
    # Build ncursesw
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-normal',
           '--with-shared',
           '--with-cxx-shared',
           '--without-debug',
           '--enable-widec'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # remove binary files which are installed by ncurses also
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/clear"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/infocmp"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/tabs"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/tic"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/tput"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/tset"
    system "rm", "#{CREW_DEST_DIR}/usr/local/bin/toe"
  end
end
