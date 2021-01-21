require 'package'

class Xorg_fbdev_driver < Package
  description 'The Xorg Fbdev Driver package contains the X.Org Video Driver for framebuffer devices. This driver is often used as fallback driver if the hardware specific and VESA drivers fail to load or are not present.'
  homepage 'https://www.x.org'
  version '0.4.4'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/driver/xf86-video-fbdev-0.4.4.tar.bz2'
  source_sha256 '9dd4b326498223abbfdf786089a46ea3db4fa6bbd341308eb48a9e00bc3fd51b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_fbdev_driver-0.4.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_fbdev_driver-0.4.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_fbdev_driver-0.4.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_fbdev_driver-0.4.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '865f82f5fa3190d900f03f05f45980185a098a186344ab8fe8a40564bd4faf4c',
     armv7l: '865f82f5fa3190d900f03f05f45980185a098a186344ab8fe8a40564bd4faf4c',
       i686: '645cc4317fc56a716324224cbd9e20e2b42865e4c3bbeccb7cc113739b52b1b7',
     x86_64: '3dbeadf9bf8753c28c9950a9ce6d45583e52e8ad0e629caf422ba62968985137',
  })

  depends_on 'xorg_server' => :build

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end
