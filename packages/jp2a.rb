require 'package'

class Jp2a < Package
  description 'jp2a is a simple JPEG/PNG to ASCII converter.'
  homepage 'https://github.com/Talinx/jp2a'
  version '1.1.0'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/Talinx/jp2a/releases/download/v1.1.0/jp2a-1.1.0.tar.bz2"
  source_sha256 '6017b83f10bae352c7786868a977a02080a4e84fb99e6fbad18086fcfedffdf4'
  
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'termcap'
  
  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-curl"
    system "make"
  end

  def self.check
    system "make check || true"
  end
  
  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
