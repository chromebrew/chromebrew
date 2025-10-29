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
    aarch64: 'b1ec533b10ebaca34474b8876e26b2ad9dfda3dab193e71a4caeddb4db3a6f38',
     armv7l: 'b1ec533b10ebaca34474b8876e26b2ad9dfda3dab193e71a4caeddb4db3a6f38',
       i686: 'f7b9cba3d12a9e999228b0143a617a768f2f90f897ee06588d581313c92f0e5c',
     x86_64: '5517a4b11a9cd8789f32f700942c6627f872b4e742b6175dcb9746fc3795963f'
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
