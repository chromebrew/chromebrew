require 'package'

class Libvorbis < Package
  description 'Ogg Vorbis is a fully open, non-proprietary, patent-and-royalty-free, general-purpose compressed audio format.'
  homepage 'https://xiph.org/vorbis/'
  version '1.3.3'
  source_url 'http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.xz'
  source_sha1 '31d1a0ec4815bf1ee638b0f2850f03efcd48022a'

  depends_on 'libogg'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
