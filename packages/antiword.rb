require 'package'

class Antiword < Package
  description 'Antiword is a free MS Word reader for Linux and RISC OS.'
  homepage 'http://www.winfield.demon.nl/'
  version '0.37'
  source_url 'http://www.winfield.demon.nl/linux/antiword-0.37.tar.gz'
  source_sha256 '8e2c000fcbc6d641b0e6ff95e13c846da3ff31097801e86702124a206888f5ac'

  def self.build
    system 'make'
  end

  def self.install
    system "sed -i 's,GLOBAL_RESOURCES_DIR = /usr/share/antiword,GLOBAL_RESOURCES_DIR = /usr/local/share/antiword,' Makefile.Linux"
    system "sed -i 's,/share/,/,g' antiword.h"
    system "sed -i 's,/usr/antiword,/usr/local/share/antiword,g' antiword.h"
    system "sed -i 's,/usr/share/antiword,/usr/local/share/antiword,' Docs/antiword.1"
    system "mkdir /home/#{USER}/user/.antiword"
    system "mkdir -p #{CREW_DEST_DIR}/home/#{USER}/user/.antiword"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man1"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/share/antiword"
    system "cp antiword #{CREW_DEST_DIR}/usr/local/bin"
    system "cp Docs/antiword.1 #{CREW_DEST_DIR}/usr/local/man/man1"
    system "cp Resources/* #{CREW_DEST_DIR}/usr/local/share/antiword"
    system "cp Resources/UTF-8.txt /home/#{USER}/user/.antiword"
    system "cp Resources/UTF-8.txt #{CREW_DEST_DIR}/home/#{USER}/user/.antiword"
  end
end
