require 'package'
class Yasm < Package
  version '1.3.0'
  description 'Yasm is a complete rewrite of the NASM assembler under the new BSD License.'
  homepage 'http://yasm.tortall.net/'
  source_url 'http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz'
  source_sha1 'b7574e9f0826bedef975d64d3825f75fbaeef55e'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install"
  end
end
