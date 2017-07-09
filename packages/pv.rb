require 'package'

class Pv < Package
  description 'pv - Pipe Viewer - is a terminal-based tool for monitoring the progress of data through a pipeline.'
  homepage 'http://www.ivarch.com/programs/pv.shtml'
  version '1.6.0'
  source_url 'http://www.ivarch.com/programs/sources/pv-1.6.0.tar.gz'
  source_sha256 '9dd45391806b0ed215abee4c5ac1597d018c386fe9c1f5afd2f6bc3b07fd82c3'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pv-1.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pv-1.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/pv-1.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/pv-1.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9e599d6a6b88d50eb15f9c19b357a48fbf335af14efadff26713ecf185befeb7',
     armv7l: '9e599d6a6b88d50eb15f9c19b357a48fbf335af14efadff26713ecf185befeb7',
       i686: 'bc1128f2d36edc6606e74b08856f0fa24a75e8e2a9983c00411f391a7c63caf4',
     x86_64: '4e0fd20ab3d76c3bede089c681fae98eada254f4a34e18eea7087f2deb082106',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
