require 'package'

class Antiword < Package
  description 'Antiword is a free MS Word reader for Linux and RISC OS.'
  homepage 'http://www.winfield.demon.nl/'
  version '0.37-1'
  source_url 'http://www.winfield.demon.nl/linux/antiword-0.37.tar.gz'
  source_sha256 '8e2c000fcbc6d641b0e6ff95e13c846da3ff31097801e86702124a206888f5ac'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/antiword-0.37-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/antiword-0.37-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/antiword-0.37-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/antiword-0.37-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bf715a95e9b95ad8a7cb154d69f9489d9eb55145b85dc2cdff18f1ebac8a942d',
     armv7l: 'bf715a95e9b95ad8a7cb154d69f9489d9eb55145b85dc2cdff18f1ebac8a942d',
       i686: '91586f23b5cddb8918a3fa83f43387516b4576e1be900d608b5a3bde6aeccbfd',
     x86_64: 'c73e352b73ff7ac4007426b339f8100e97810efb5ff7c77fb0f62aa794d0b473',
  })

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
