require 'package'

class Fpc < Package
  description 'Free Pascal is a 32, 64 and 16 bit professional Pascal compiler.'
  homepage 'https://www.freepascal.org/'
  version '3.2.0'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://downloads.sourceforge.net/project/freepascal/Linux/3.2.0/fpc-3.2.0.arm-linux.tar'
    source_sha256 'b78c72859e1e147e33991e1bb1e937654859799ae2afc145257c834a8d52737e'
  when 'i686'
    source_url 'https://downloads.sourceforge.net/project/freepascal/Linux/3.2.0/fpc-3.2.0.i386-linux.tar'
    source_sha256 '2110eb1d7a35311f587694f9b25dc2660e0116eafd9884c4c7ab2f2716080578'
  when 'x86_64'
    source_url 'https://downloads.sourceforge.net/project/freepascal/Linux/3.2.0/fpc-3.2.0-x86_64-linux.tar'
    source_sha256 'd19252e6cfe52f1217f4822a548ee699eaa7e044807aaf8429a0532cb7e4cb3d'
  end

  def self.build
    system "sed -i 's,PREFIX=\"\$HOME/fpc-\$VERSION\",PREFIX=#{CREW_DEST_PREFIX},' install.sh"
    system "sed -i '264,272d' install.sh"
  end

  def self.install
    system './install.sh'
  end

  def self.postinstall
    puts
    puts "Type 'fp' to start.".lightblue
    puts
  end
end
