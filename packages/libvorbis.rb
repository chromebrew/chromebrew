require 'package'

class Libvorbis < Package
  description 'Ogg Vorbis is a fully open, non-proprietary, patent-and-royalty-free, general-purpose compressed audio format.'
  homepage 'https://xiph.org/vorbis/'
  version '1.3.5'
  compatibility 'all'
  source_url 'https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.tar.xz'
  source_sha256 '54f94a9527ff0a88477be0a71c0bab09a4c3febe0ed878b24824906cd4b0e1d1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libvorbis-1.3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libvorbis-1.3.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libvorbis-1.3.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libvorbis-1.3.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8a3d930a7aa9324121b84b45f81454299004ee37b7326c35afc20dbf9ff19619',
     armv7l: '8a3d930a7aa9324121b84b45f81454299004ee37b7326c35afc20dbf9ff19619',
       i686: '8989a74129fb2605eda7d5a011d3edaed81d725031b8bc466017bafd5d21caf6',
     x86_64: 'ec8103fc056bc0598a1715d43d18d5456d941dfb39f20d909247c745ae2c5f88',
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
