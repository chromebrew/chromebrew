require 'package'

class Libvorbis < Package
  description 'Ogg Vorbis is a fully open, non-proprietary, patent-and-royalty-free, general-purpose compressed audio format.'
  homepage 'https://xiph.org/vorbis/'
  version '1.3.5'
  source_url 'https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.tar.xz'
  source_sha256 '54f94a9527ff0a88477be0a71c0bab09a4c3febe0ed878b24824906cd4b0e1d1'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libogg'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
