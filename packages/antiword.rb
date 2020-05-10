require 'package'

class Antiword < Package
  description 'Antiword is a free MS Word reader for Linux and RISC OS.'
  homepage 'http://www.winfield.demon.nl/'
  version '0.37-2'
  compatibility 'all'
  source_url 'http://www.winfield.demon.nl/linux/antiword-0.37.tar.gz'
  source_sha256 '8e2c000fcbc6d641b0e6ff95e13c846da3ff31097801e86702124a206888f5ac'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/antiword-0.37-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/antiword-0.37-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/antiword-0.37-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/antiword-0.37-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '758ead9af6bdc9493b525d9e009e1f5edb3fa51ca1663d66dd8f43b89b821225',
     armv7l: '758ead9af6bdc9493b525d9e009e1f5edb3fa51ca1663d66dd8f43b89b821225',
       i686: '54276a60100d021bc6d619f175d3ca592f872a151eed6557fd09d87a6b2a6ea9',
     x86_64: '5486ee47684aaf249f0f75f9c903aa8c79b41466ae94aa0dbbd660090af438d0',
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
