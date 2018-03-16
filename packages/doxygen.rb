require 'package'

class Doxygen < Package
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources'
  homepage 'http://www.stack.nl/~dimitri/doxygen/'
  version '1.8.14-0'
  source_url 'https://github.com/doxygen/doxygen/archive/Release_1_8_14.tar.gz'
  source_sha256 '18bc3790b4d5f4d57cb8ee0a77dd63a52518f3f70d7fdff868a7ce7961a6edc3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '7b9c085e0b949dc392fbef741fffb1990ca5c4e4da9574e70bc78f404c4f6823',
     armv7l: '7b9c085e0b949dc392fbef741fffb1990ca5c4e4da9574e70bc78f404c4f6823',
       i686: 'ffdefe84883879da73bba23ea6aed9cf652efa868b384910b0830afcd5028b15',
     x86_64: 'd6627ee0caad73c73f622d49c4a2702680d66bc231ef1d42acf9f61fa0949644',
    
  })

  depends_on 'cmake' => :build
  depends_on 'python27' => :build

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
