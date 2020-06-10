require 'package'

class Xcb_util_renderutil < Package
  description 'The xcb-util-renderutil package provides additional extensions to the XCB library'
  homepage 'https://xcb.freedesktop.org/'
  version '0.3.9'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-renderutil-0.3.9.tar.bz2'
  source_sha256 'c6e97e48fb1286d6394dddb1c1732f00227c70bd1bedb7d1acabefdd340bea5b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_renderutil-0.3.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_renderutil-0.3.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_renderutil-0.3.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_renderutil-0.3.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e3f17ab33870d9b12bacc3916be4e4069688923178501e22dafd14fe77ec8534',
     armv7l: 'e3f17ab33870d9b12bacc3916be4e4069688923178501e22dafd14fe77ec8534',
       i686: '4bcceaedf822e3a913166e0940e6003cf231329850a356d7de2e7fba8201f68f',
     x86_64: '31db25a833ede1ba59652737de86228e024157e903682dba095de797d5dfe800',
  })

  depends_on 'libxcb'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
