require 'package'

class Most < Package
  description 'MOST is a powerful paging program for Unix, VMS, MSDOS, and win32 systems.'
  homepage 'http://www.jedsoft.org/most/'
  version 'pre5.1-20-1'
  source_url 'https://www.jedsoft.org/snapshots/most-pre5.1-20.tar.gz'
  source_sha256 '59b02c9f131c5fb0e20f952ca34bcf90919251f585bbf014dfb5c281d699388d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/most-pre5.1-20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/most-pre5.1-20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/most-pre5.1-20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/most-pre5.1-20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '181130263ca17d63be8d4933493c27e0a823cf642c318e8e407d2278e58d1248',
     armv7l: '181130263ca17d63be8d4933493c27e0a823cf642c318e8e407d2278e58d1248',
       i686: 'd4d7b56bb11a12910defbfa91d81faec24564f1f123a55691a7464d247cb2653',
     x86_64: '75252b49089c84486e7a611ea07e0154ca06ee1b24f2deafd6c343181c112880',
  })

  depends_on 'slang'

  def self.build
    system "sed -i 's,ncurses5,ncurses6,g' configure"
    system "sed -i 's,ncursesw5,ncursesw6,g' configure"
    system "sed -i 's,ncurses5,ncurses6,g' autoconf/aclocal.m4"
    system "sed -i 's,ncursesw5,ncursesw6,g' autoconf/aclocal.m4"
    system "./configure --prefix=#{CREW_PREFIX}"
    system "sed -i '36d' Makefile"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
