require 'package'

class Lshw < Package
  description 'lshw (Hardware Lister) is a small tool to provide detailed information on the hardware configuration of the machine.'
  homepage 'https://www.ezix.org/project/wiki/HardwareLiSter'
  version 'B.02.18'
  compatibility 'all'
  source_url 'http://www.ezix.org/software/files/lshw-B.02.18.tar.gz'
  source_sha256 'ae22ef11c934364be4fd2a0a1a7aadf4495a0251ec6979da280d342a89ca3c2f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lshw-B.02.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lshw-B.02.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lshw-B.02.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lshw-B.02.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd6d2db90b1df3ac02f53c01188a23230e8d2a11935487e03a8b61c4ecdc888be',
     armv7l: 'd6d2db90b1df3ac02f53c01188a23230e8d2a11935487e03a8b61c4ecdc888be',
       i686: '07466f0d1d09a1536eb2e5348526b97b7f9c7a8cdb601ba3c26b566a765e6f64',
     x86_64: 'fe6c4b1a6936defcc6685777898cfbe2f9793c897fa5bdcc18d9518907c65406',
  })

  def self.build
    system "cd lshw-*/src; PREFIX=#{CREW_PREFIX} make"
  end

  def self.install
    system "cd lshw-*/src; PREFIX=#{CREW_PREFIX} make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
