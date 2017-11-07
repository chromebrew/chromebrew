require 'package'

class Libvorbis < Package
  description 'Ogg Vorbis is a fully open, non-proprietary, patent-and-royalty-free, general-purpose compressed audio format.'
  homepage 'https://xiph.org/vorbis/'
  version '1.3.3'
  source_url 'http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.xz'
  source_sha256 '834c7d35a5ebf4e7b8ab60b0979f2b7f204ca66ff6829728e9d2a67f15347ebd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libvorbis-1.3.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libvorbis-1.3.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libvorbis-1.3.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libvorbis-1.3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c65ed9d47d0d133e70fe045796eec9ebde88c964b23ff26ca6114bea1b21157d',
     armv7l: 'c65ed9d47d0d133e70fe045796eec9ebde88c964b23ff26ca6114bea1b21157d',
       i686: '5acc6baa7d5ac534e73e231d4c0bdeed69ec51e3d5f9d03dbf9648d14fa5bad6',
     x86_64: '23d1e4a79c95d510e72a3ca78744bcdd1a09a40a9b900b8a6821b0b3fb86f47e',
  })

  depends_on 'libogg'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
