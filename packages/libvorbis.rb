require 'package'

class Libvorbis < Package
  description 'Ogg Vorbis is a fully open, non-proprietary, patent-and-royalty-free, general-purpose compressed audio format.'
  homepage 'https://xiph.org/vorbis/'
  version '1.3.3'
  source_url 'http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.xz'
  source_sha256 '834c7d35a5ebf4e7b8ab60b0979f2b7f204ca66ff6829728e9d2a67f15347ebd'

  depends_on 'libogg'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
