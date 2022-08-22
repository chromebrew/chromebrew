require 'package'

class Flac < Package
  description 'FLAC stands for Free Lossless Audio Codec, an audio format similar to MP3, but lossless, meaning that audio is compressed in FLAC without any loss in quality.'
  homepage 'https://xiph.org/flac/'
  version '1.3.3'
  compatibility 'all'
  license 'BSD, FDL-1.2, GPL-2 and LGPL-2.1'
  source_url 'https://downloads.xiph.org/releases/flac/flac-1.3.3.tar.xz'
  source_sha256 '213e82bd716c9de6db2f98bcadbc4c24c7e2efe8c75939a1a84e28539c4e1748'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flac/1.3.3_armv7l/flac-1.3.3-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flac/1.3.3_armv7l/flac-1.3.3-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flac/1.3.3_i686/flac-1.3.3-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/flac/1.3.3_x86_64/flac-1.3.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a3cb51ffedc2d355e22149c1240a46586703296317458c4b1f0b10116686320e',
      armv7l: 'a3cb51ffedc2d355e22149c1240a46586703296317458c4b1f0b10116686320e',
        i686: '339e9891d19711c5f8fbd71ef4fce8e1160fddbbb7b84219dfc9c80796679977',
      x86_64: 'e130ba18fcc4d28f2cadd84930dce8f51577ab121451859336bbb0bd3f5ea8a1'
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
    system 'make', 'check'
  end
end
