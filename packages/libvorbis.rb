require 'package'

class Libvorbis < Package
  description 'Ogg Vorbis is a fully open, non-proprietary, patent-and-royalty-free, general-purpose compressed audio format.'
  homepage 'https://xiph.org/vorbis/'
  version '1.3.7'
  compatibility 'all'
  license 'BSD'
  source_url 'https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.7.tar.xz'
  source_sha256 'b33cc4934322bcbf6efcbacf49e3ca01aadbea4114ec9589d1b1e9d20f72954b'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvorbis/1.3.7_armv7l/libvorbis-1.3.7-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvorbis/1.3.7_armv7l/libvorbis-1.3.7-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvorbis/1.3.7_i686/libvorbis-1.3.7-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvorbis/1.3.7_x86_64/libvorbis-1.3.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd7887b0f9a491d6b9b1e6d0998988c71a398dd0734a8cdc3a9a8973acaa1e5e0',
      armv7l: 'd7887b0f9a491d6b9b1e6d0998988c71a398dd0734a8cdc3a9a8973acaa1e5e0',
        i686: '71033a9a6d323bcf3b81376b151bce904ad9e3d16369d4c2e3a5dcda22074b76',
      x86_64: '155962844a425ab407ce4c38e2a0ee8960059699c4559e3fcedf449b6e5592f0'
  })

  depends_on 'libogg'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # system 'make', 'check'
  end
end
