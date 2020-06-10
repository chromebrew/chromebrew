require 'package'

class Pagemon < Package
  description 'Pagemon is an interactive memory/page monitoring tool allowing one to browse the memory map of an active running process.'
  homepage 'http://kernel.ubuntu.com/~cking/pagemon/'
  version '0.01.10'
  compatibility 'all'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/pagemon/pagemon-0.01.10.tar.gz'
  source_sha256 '82c240b44b7000fc57355b366bfe28a47a4da857ddaea0ee0ade9d3eae037f54'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pagemon-0.01.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pagemon-0.01.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pagemon-0.01.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pagemon-0.01.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '83b518d6b28a899e94c40ed5cf23e4ddae10f67fcd10a2e9664d15f94d910f02',
     armv7l: '83b518d6b28a899e94c40ed5cf23e4ddae10f67fcd10a2e9664d15f94d910f02',
       i686: '66ade8bf2dd6cf5eb730a17d17bb754cf80212be05bbcb5b790763736d109efe',
     x86_64: '084d8ab1ccd2ba203554523f4a5f579be554f58a31cf360524a3f3ca10343a9e',
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncurses/' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
