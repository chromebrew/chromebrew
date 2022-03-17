require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library, with APNG support packaged in.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.37'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/libpng/files/libpng16/1.6.37/libpng-1.6.37.tar.xz'
  source_sha256 '505e70834d35383537b6491e7ae8641f1a4bed1876dbfe361201fc80868d88ca'

  def self.patch
    downloader 'https://sourceforge.net/projects/libpng-apng/files/libpng16/1.6.37/libpng-1.6.37-apng.patch.gz'
    system 'gunzip -c libpng-1.6.37-apng.patch.gz | patch -Np1'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
