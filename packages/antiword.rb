require 'package'

class Antiword < Package
  description 'Antiword is a free MS Word reader for Linux and RISC OS.'
  homepage 'http://www.winfield.demon.nl/'
  version '0.37-2'
  source_url 'http://www.winfield.demon.nl/linux/antiword-0.37.tar.gz'
  source_sha256 '8e2c000fcbc6d641b0e6ff95e13c846da3ff31097801e86702124a206888f5ac'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sed -i 's,GLOBAL_RESOURCES_DIR = /usr/share/antiword,GLOBAL_RESOURCES_DIR = #{CREW_PREFIX}/share/antiword,' Makefile.Linux"
    system "sed -i 's,/share/,/,g' antiword.h"
    system "sed -i 's,/usr/antiword,#{CREW_PREFIX}/share/antiword,g' antiword.h"
    system "sed -i 's,/usr/share/antiword,#{CREW_PREFIX}/share/antiword,' Docs/antiword.1"
    system "make"
  end

  def self.install
    system "mkdir -p /home/#{USER}/user/.antiword"
    system "mkdir -p #{CREW_DEST_DIR}/home/#{USER}/user/.antiword"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/antiword"
    system "cp antiword #{CREW_DEST_PREFIX}/bin"
    system "cp Docs/antiword.1 #{CREW_DEST_PREFIX}/man/man1"
    system "cp Resources/* #{CREW_DEST_PREFIX}/share/antiword"
    system "cp Resources/UTF-8.txt /home/#{USER}/user/.antiword"
    system "cp Resources/UTF-8.txt #{CREW_DEST_DIR}/home/#{USER}/user/.antiword"
  end
end
