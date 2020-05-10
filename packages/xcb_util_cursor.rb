require 'package'

class Xcb_util_cursor < Package
  description 'The xcb-util-cursor package provides a module that implements the XCB cursor library. It is a the XCB replacement for libXcursor.'
  homepage 'http://xcb.freedesktop.org'
  version '0.1.3'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-cursor-0.1.3.tar.bz2'
  source_sha256 '05a10a0706a1a789a078be297b5fb663f66a71fb7f7f1b99658264c35926394f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_cursor-0.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_cursor-0.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_cursor-0.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_cursor-0.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8049a324950ee5f84a3397d4f32131b9db6ce64a3209a5f8d89a77f0e58d58f0',
     armv7l: '8049a324950ee5f84a3397d4f32131b9db6ce64a3209a5f8d89a77f0e58d58f0',
       i686: 'affd9e774332aa1b0bdd870db784febded0fd1aedc53ddcf71e0b8ef3827d776',
     x86_64: '997331d8cbdf24d6f934e0b1e9f17a4208671c8ad3f5deab50e3a3160e998b4f',
  })

  depends_on 'xcb_util'
  depends_on 'm4'
  depends_on 'xcb_util_renderutil'
  depends_on 'xcb_util_image'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
