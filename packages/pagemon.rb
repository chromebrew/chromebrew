require 'package'

class Pagemon < Package
  description 'Pagemon is an interactive memory/page monitoring tool allowing one to browse the memory map of an active running process.'
  homepage 'https://kernel.ubuntu.com/~cking/pagemon/'
  version '0.01.10-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/pagemon/pagemon-0.01.10.tar.gz'
  source_sha256 '82c240b44b7000fc57355b366bfe28a47a4da857ddaea0ee0ade9d3eae037f54'

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncursesw/' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
