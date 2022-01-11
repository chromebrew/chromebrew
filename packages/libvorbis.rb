require 'package'

class Libvorbis < Package
  description 'Ogg Vorbis is a fully open, non-proprietary, patent-and-royalty-free, general-purpose compressed audio format.'
  homepage 'https://xiph.org/vorbis/'
  version '1.3.7'
  license 'BSD'
  compatibility 'all'
  source_url 'https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.7.tar.xz'
  source_sha256 'b33cc4934322bcbf6efcbacf49e3ca01aadbea4114ec9589d1b1e9d20f72954b'

  depends_on 'libogg'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
