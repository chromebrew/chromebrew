require 'package'

class Libfrei0r < Package
  description 'Minimalistic API for a collection of free video effect plugins.'
  homepage 'https://frei0r.dyne.org/'
  version '1.6.1'
  compatibility 'all'
  source_url 'https://github.com/dyne/frei0r/archive/v1.6.1.tar.gz'
  source_sha256 'dae0ca623c83173788ce4fc74cb67ac7e50cf33a4412ee3d33bed284da1a8437'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfrei0r-1.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfrei0r-1.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfrei0r-1.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfrei0r-1.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bd9381d2c456c270133c206c66e94ed5f77a856bd23d18138d92df6b4e2c7759',
     armv7l: 'bd9381d2c456c270133c206c66e94ed5f77a856bd23d18138d92df6b4e2c7759',
       i686: '97eed475d2ad73584e604455e9d7b8c09d6348b0b0ade255f369eae4d1f6a4c7',
     x86_64: '73646984853d48487d8881cdc4a9ac3fd35f08e8384be54db9948a6d41046d23',
  })

  def self.build
    system "cmake . -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_CXX_FLAGS=' -L#{CREW_LIB_PREFIX}'"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
