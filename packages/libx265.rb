require 'package'

class Libx265 < Package
  description 'x265 is a H.265 / HEVC video encoder application library.'
  homepage 'http://x265.org/'
  version '2.6'
  compatibility 'all'
  source_url 'https://bitbucket.org/multicoreware/x265/downloads/x265_2.6.tar.gz'
  source_sha256 '1bf0036415996af841884802161065b9e6be74f5f6808ac04831363e2549cdbf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libx265-2.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libx265-2.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libx265-2.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libx265-2.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4ffe8a816ecc0350d749579f22278e3e9786cb52279829a1f8753205e1d1a03f',
     armv7l: '4ffe8a816ecc0350d749579f22278e3e9786cb52279829a1f8753205e1d1a03f',
       i686: '73a02413698d13621385cb9f5bc553bc154622e907ed4aa25a51ae54f0ee90c4',
     x86_64: '4bd7fd7b202ab7f59f338e51ea832a5dbef00775af2cf7e7ae6ba6cacee93fac',
  })

  depends_on 'cmake' => :build
  depends_on 'yasm' => :build

  def self.build
    FileUtils.cd('build') do
      system "cmake ../source -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
      system "sed -i 's,{CMAKE_INSTALL_PREFIX}/lib,{CMAKE_INSTALL_PREFIX}/lib64,g' cmake_install.cmake" if ARCH == 'x86_64'
      system "make"
    end
  end

  def self.install
    FileUtils.cd('build') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
