require 'package'

class Libusb < Package
  description 'A cross-platform library that gives apps easy access to USB devices'
  homepage 'https://sourceforge.net/projects/libusb/'
  version '1.0.29'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/libusb/libusb/releases/download/v#{version}/libusb-#{version}.tar.bz2"
  source_sha256 '5977fc950f8d1395ccea9bd48c06b3f808fd3c2c961b44b0c2e6e29fc3a70a85'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31dc0f4774997cdadb78ead5d59f436a0c638270312c04987bfd8027ea3f9841',
     armv7l: '31dc0f4774997cdadb78ead5d59f436a0c638270312c04987bfd8027ea3f9841',
       i686: '43ef832c441248eabce9fc83affcae4c5e689de2d34c9d7547ed4ca740ad99a1',
     x86_64: '2891bf3ae30078cd88dbd703a028c401ac0e735f0c86a3d971b80789a3562029'
  })

  depends_on 'eudev'

  def self.build
    system "./configure \
      #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
