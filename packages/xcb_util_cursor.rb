require 'package'

class Xcb_util_cursor < Package
  description 'The xcb-util-cursor package provides a module that implements the XCB cursor library. It is a the XCB replacement for libXcursor.'
  homepage 'http://xcb.freedesktop.org'
  version '0.1.3'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-cursor-0.1.3.tar.bz2'
  source_sha256 '05a10a0706a1a789a078be297b5fb663f66a71fb7f7f1b99658264c35926394f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xcb_util'
  depends_on 'm4'
  depends_on 'xcb_util_renderutil'
  depends_on 'xcb_util_image'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
