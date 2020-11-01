require 'package'

class Libxrandr < Package
  description 'X.org X Resize, Rotate and Reflection extension library'
  homepage 'http://www.x.org'
  version '1.5.2-1'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXrandr-1.5.2.tar.gz'
  source_sha256 '3f10813ab355e7a09f17e147d61b0ce090d898a5ea5b5519acd0ef68675dcf8e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxrandr-1.5.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '795885bddb9431b2522f1d78ced0bcf06dcbbb988b1aec402223a8d5c42ad4ba',
     armv7l: '795885bddb9431b2522f1d78ced0bcf06dcbbb988b1aec402223a8d5c42ad4ba',
       i686: 'c744ec234f8362ce658f5acccfd978287e73f7a41d64ca2a0593de096b6ec41d',
     x86_64: 'c4d10ac43c01b0e857536b939775597ffe0adf533925c1a2146695213f10f7c9',
  })

  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxrender'
  depends_on 'llvm' => :build

  def self.build
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
