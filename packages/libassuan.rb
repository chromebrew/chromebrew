require 'package'

class Libassuan < Package
  description 'Libassuan is a small library implementing the so-called Assuan protocol.'
  homepage 'https://www.gnupg.org/related_software/libassuan/index.html'
  version '2.4.3'
  source_url 'https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.4.3.tar.bz2'
  source_sha256 '22843a3bdb256f59be49842abf24da76700354293a066d82ade8134bb5aa2b71'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libassuan-2.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libassuan-2.4.3-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libassuan-2.4.3-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libassuan-2.4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c582619a230bd2f766ff2b10d6d8a61a433314491ed34a5c332c54904dc8bfe2',
     armv7l: 'c582619a230bd2f766ff2b10d6d8a61a433314491ed34a5c332c54904dc8bfe2',
       i686: '932dfeb2bce8fc736c89bffe10713e366a867722bf807cfdcfbd7fcc2f9a78f2',
     x86_64: '05dd4fd2634875a990ab4abd1f3d477deaaee37c7015d08b59b31d1e369fc9b9',
  })

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
