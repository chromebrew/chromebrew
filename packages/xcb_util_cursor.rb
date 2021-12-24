require 'package'

class Xcb_util_cursor < Package
  description 'The xcb-util-cursor package provides a module that implements the XCB cursor library. It is a the XCB replacement for libXcursor.'
  homepage 'http://xcb.freedesktop.org'
  version '0.1.3-1'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-cursor-0.1.3.tar.bz2'
  source_sha256 '05a10a0706a1a789a078be297b5fb663f66a71fb7f7f1b99658264c35926394f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_cursor/0.1.3-1_armv7l/xcb_util_cursor-0.1.3-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_cursor/0.1.3-1_armv7l/xcb_util_cursor-0.1.3-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_cursor/0.1.3-1_i686/xcb_util_cursor-0.1.3-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_cursor/0.1.3-1_x86_64/xcb_util_cursor-0.1.3-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'bb398e1d06d8a3abcdce6464e012876d1dae75a97497b13cf735222d83a3d97c',
     armv7l: 'bb398e1d06d8a3abcdce6464e012876d1dae75a97497b13cf735222d83a3d97c',
       i686: '4194bf613da98147959648bb97edc71c9a1b0cda5be38b73a97b65dbe384bd71',
     x86_64: '28d724010ae0b1a6c93bcff89f78bfc594d10813d280d79f12384fd09c11fb82'
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
