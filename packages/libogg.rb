require 'package'

class Libogg < Package
  description 'Ogg is a multimedia container format, and the native file and stream format for the Xiph.org multimedia codecs.'
  homepage 'https://xiph.org/ogg/'
  version '1.3.5'
  license 'BSD'
  compatibility 'all'
  source_url 'https://downloads.xiph.org/releases/ogg/libogg-1.3.5.tar.xz'
  source_sha256 'c4d91be36fc8e54deae7575241e03f4211eb102afb3fc0775fbbc1b740016705'

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
