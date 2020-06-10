require 'package'

class Libusb < Package
  description 'A cross-platform library that gives apps easy access to USB devices'
  homepage 'https://sourceforge.net/projects/libusb/'
  version '1.0.23'
  compatibility 'all'
  source_url 'https://github.com/libusb/libusb/releases/download/v1.0.23/libusb-1.0.23.tar.bz2'
  source_sha256 'db11c06e958a82dac52cf3c65cb4dd2c3f339c8a988665110e0d24d19312ad8d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.23-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.23-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.23-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '25b18e0f7bec888d717dd466c8fbbd0fe67e6bce54d052dcc52d9a004179fd0f',
     armv7l: '25b18e0f7bec888d717dd466c8fbbd0fe67e6bce54d052dcc52d9a004179fd0f',
       i686: 'eb3b3152a972b4849e28328a2d7d170ab7c795375def2173f77bf2a024a3dde9',
     x86_64: 'b59a07eb8cfbb17d6d3ba7586e360b037f4ff7f96630ea4cf9ebc8a295ae7bd6',
  })

  depends_on 'eudev'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
