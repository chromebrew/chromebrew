require 'package'

class Flac < Package
  description 'FLAC stands for Free Lossless Audio Codec, an audio format similar to MP3, but lossless, meaning that audio is compressed in FLAC without any loss in quality.'
  homepage 'https://xiph.org/flac/'
  version '1.3.3'
  license 'BSD, FDL-1.2, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://downloads.xiph.org/releases/flac/flac-1.3.3.tar.xz'
  source_sha256 '213e82bd716c9de6db2f98bcadbc4c24c7e2efe8c75939a1a84e28539c4e1748'

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
