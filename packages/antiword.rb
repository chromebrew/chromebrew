require 'package'

class Antiword < Package
  description 'Antiword is a free MS Word reader for Linux and RISC OS.'
  homepage 'http://www.winfield.demon.nl/'
  version '0.37'
  source_url 'http://www.winfield.demon.nl/linux/antiword-0.37.tar.gz'
  source_sha1 '4364f7f99cb2d37f7d1d5bc14a335ccc0c67292e'

  def self.build
    system 'make'
  end

  def self.install
    system "sed -i 's,GLOBAL_RESOURCES_DIR = /usr/share/antiword,GLOBAL_RESOURCES_DIR = /usr/local/antiword,' Makefile.Linux"
    system "sed -i 's,/share/,/,g' antiword.h"
    system "sed -i 's,/usr/antiword,/usr/local/antiword,g' antiword.h"
    system "sed -i 's,/usr/share/antiword,/usr/local/antiword,' Docs/antiword.1"
    system "mkdir /home/$(whoami)/user/.antiword"
    system "mkdir -p #{CREW_DEST_DIR}/home/$(whoami)/user/.antiword"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/antiword"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man1"
    system "cp antiword #{CREW_DEST_DIR}/usr/local/bin"
    system "cp Docs/antiword.1 #{CREW_DEST_DIR}/usr/local/man/man1"
    system "cp Resources/* #{CREW_DEST_DIR}/usr/local/antiword"
    system "cp Resources/UTF-8.txt /home/$(whoami)/user/.antiword"
    system "cp Resources/UTF-8.txt #{CREW_DEST_DIR}/home/$(whoami)/user/.antiword"
  end
end
