require 'package'

class Yasm < Package
  version '1.3.0'
  description 'Yasm is a complete rewrite of the NASM assembler under the new BSD License.'
  homepage 'http://yasm.tortall.net/'
  source_url 'http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz'
  source_sha256 '3dce6601b495f5b3d45b59f7d2492a340ee7e84b5beca17e48f862502bd5603f'

  def self.build
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install"
  end
end
