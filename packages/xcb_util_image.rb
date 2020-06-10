require 'package'

class Xcb_util_image < Package
  description 'The xcb-util-image package provides additional extensions to the XCB library.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.0'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-image-0.4.0.tar.bz2'
  source_sha256 '2db96a37d78831d643538dd1b595d7d712e04bdccf8896a5e18ce0f398ea2ffc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_image-0.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_image-0.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_image-0.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_image-0.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a8c6f9a8cd513f065756a70ec0a81a0128af0826b232be1602ad6ee24dcb2db1',
     armv7l: 'a8c6f9a8cd513f065756a70ec0a81a0128af0826b232be1602ad6ee24dcb2db1',
       i686: '738aabe9c863000ad85708cadec8d1658d0f7991f909510736d966cc27599ba9',
     x86_64: 'c0937fb88402aca9aa214737505b5686274520e100007f567991f26dbccec259',
  })

  depends_on 'xcb_util'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
