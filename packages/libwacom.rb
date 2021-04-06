require 'package'

class Libwacom < Package
  description 'libwacom is a wrapper library for evdev devices.'
  homepage 'https://github.com/linuxwacom/libwacom'
  @_ver = 1.8
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/linuxwacom/libwacom/releases/download/libwacom-#{@_ver}/libwacom-#{@_ver}.tar.bz2"
  source_sha256 '2e8075e60bbef74fe9c3539b0a0080efab28912b2552784d8b54dbbf1aaa63e5'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwacom-1.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwacom-1.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwacom-1.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwacom-1.8-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7029db156ea3a27a9024f12071cb1fb99a54f233b1df0b3c5eb6174d5e5a54fd',
     armv7l: '7029db156ea3a27a9024f12071cb1fb99a54f233b1df0b3c5eb6174d5e5a54fd',
       i686: '9c1f8a3548b8d374e7da99311b9ecd88781989f605ef7fa4f3b703f5bd8e6cf7',
     x86_64: 'bd25043dcd7c6affa57e04ac2c9b6abebefa03ca7c6f83cb5c64827562ccf770'
  })

  depends_on 'libgudev'
  depends_on 'eudev'
  depends_on 'libevdev'
  depends_on 'py3_pyudev' => :build
  depends_on 'py3_pytest' => :build
  depends_on 'py3_libevdev' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dtests=disabled \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
