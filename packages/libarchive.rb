require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  @_ver = '3.5.1'
  version @_ver
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{@_ver}.tar.xz"
  source_sha256 '0e17d3a8d0b206018693b27f08029b598f6ef03600c2b5d10c94ce58692e299b'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.5.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.5.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.5.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libarchive-3.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '1f88febf96c404466b7e86849b291ecd8e3086021b6fd3fb6b4887f3935e24d8',
      armv7l: '1f88febf96c404466b7e86849b291ecd8e3086021b6fd3fb6b4887f3935e24d8',
        i686: '457630efbf3cb6af9a88cd3229407e416ec478b78c176bd3735c40f1edbfd192',
      x86_64: 'f70e487934dfd505812e01ae2d4cf2c7fc7077cab847240b9f0d840f7d360f55',
  })

  depends_on 'lz4'
  depends_on 'xzutils' => :build

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
