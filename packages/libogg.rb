require 'package'

class Libogg < Package
  description 'Ogg is a multimedia container format, and the native file and stream format for the Xiph.org multimedia codecs.'
  homepage 'https://xiph.org/ogg/'
  version '1.3.5'
  compatibility 'all'
  license 'BSD'
  source_url 'https://downloads.xiph.org/releases/ogg/libogg-1.3.5.tar.xz'
  source_sha256 'c4d91be36fc8e54deae7575241e03f4211eb102afb3fc0775fbbc1b740016705'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libogg/1.3.5_armv7l/libogg-1.3.5-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libogg/1.3.5_armv7l/libogg-1.3.5-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libogg/1.3.5_i686/libogg-1.3.5-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libogg/1.3.5_x86_64/libogg-1.3.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9daa22080ed04c1b0eeae000e3c13fbbb773e6ee2b1031227f9d8fa7c184c62f',
      armv7l: '9daa22080ed04c1b0eeae000e3c13fbbb773e6ee2b1031227f9d8fa7c184c62f',
        i686: '7a4ee216f26bd4bf3710a52fac2860a21b97dec94f7ab86889f1a277167f9f13',
      x86_64: '548abef188ab0f91d9affc901f4709d0019d06d4726edc8093d88ffc52a3be31'
  })

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
