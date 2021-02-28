require 'package'

class Libusb < Package
  description 'A cross-platform library that gives apps easy access to USB devices'
  homepage 'https://sourceforge.net/projects/libusb/'
  @_ver = '1.0.24'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/libusb/libusb/releases/download/v#{@_ver}/libusb-#{@_ver}.tar.bz2"
  source_sha256 '7efd2685f7b327326dcfb85cee426d9b871fd70e22caa15bb68d595ce2a2b12a'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.24-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.24-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.24-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.24-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'ded8613e843afa15f3cee5cebfd443b46cd628184de64564df93104ceff11de2',
      armv7l: 'ded8613e843afa15f3cee5cebfd443b46cd628184de64564df93104ceff11de2',
        i686: '492b39ccfc194a917db879576b50d0b888c9036c70e7f0f15c39c7b427a75d4f',
      x86_64: 'ceb4addc8cbb3e1e6a72549ef699514ed20ecb2b40d4277a42702b2c13f24491',
  })

  depends_on 'eudev'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
