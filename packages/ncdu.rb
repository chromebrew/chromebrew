require 'package'

class Ncdu < Package
  description 'Ncdu is a disk usage analyzer with an ncurses interface.'
  homepage 'https://dev.yorhel.nl/ncdu'
  version '1.12'
  compatibility 'all'
  source_url 'https://dev.yorhel.nl/download/ncdu-1.12.tar.gz'
  source_sha256 '820e4e4747a2a2ec7a2e9f06d2f5a353516362c22496a10a9834f871b877499a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ncdu-1.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ncdu-1.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ncdu-1.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncdu-1.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ac04b6c7a0c6ac7b9bf75636806e12539631d5617bb85ed9ed9c8536c95062a6',
     armv7l: 'ac04b6c7a0c6ac7b9bf75636806e12539631d5617bb85ed9ed9c8536c95062a6',
       i686: '095cd7dc346f99bb9e3e4361f35e034636efb0b68d4b22f9320c72cb0c782164',
     x86_64: '5b764d5d1f4bc9186384e2aa3d7c51aa84c9c2ed1f6eb78a0ac3ed431d875745',
  })

  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
