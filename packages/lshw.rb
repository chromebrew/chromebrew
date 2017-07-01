require 'package'

class Lshw < Package
  description 'lshw (Hardware Lister) is a small tool to provide detailed information on the hardware configuration of the machine.'
  homepage 'https://www.ezix.org/project/wiki/HardwareLiSter'
  version 'B.02.18'
  source_url 'http://www.ezix.org/software/files/lshw-B.02.18.tar.gz'
  source_sha256 'ae22ef11c934364be4fd2a0a1a7aadf4495a0251ec6979da280d342a89ca3c2f'

  def self.build
    system "cd lshw-*/src; PREFIX=/usr/local make"
  end

  def self.install
    system "cd lshw-*/src; PREFIX=/usr/local make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
