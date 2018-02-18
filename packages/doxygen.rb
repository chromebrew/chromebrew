require 'package'

class Doxygen < Package
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources'
  homepage 'http://www.stack.nl/~dimitri/doxygen/'
  version '1.8.14'
  source_url 'https://github.com/doxygen/doxygen/archive/Release_1_8_14.tar.gz'
  source_sha256 '18bc3790b4d5f4d57cb8ee0a77dd63a52518f3f70d7fdff868a7ce7961a6edc3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a787a8e520e656ff86284638cb2750a0a96ba457f435b92e79492b1d44a57f19',
     armv7l: 'a787a8e520e656ff86284638cb2750a0a96ba457f435b92e79492b1d44a57f19',
       i686: 'd93402dc56f6758a68cf9d13f297322e62b758c5b77378064e52c44ced929dd5',
     x86_64: '6373172fab94d0834508c943249aefd8bc364347f67a8c4a0aa15b9d05ef33b4',
  })

  depends_on 'cmake' => :build

  def self.build
    system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_DEST_PREFIX} ."
    system "make"
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
