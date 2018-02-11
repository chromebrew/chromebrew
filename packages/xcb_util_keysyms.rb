require 'package'

class Xcb_util_keysyms < Package
  description 'The xcb-util-keysyms package contains a library for handling standard X key constants and conversion to/from keycodes.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.0'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-keysyms-0.4.0.tar.bz2'
  source_sha256 '0ef8490ff1dede52b7de533158547f8b454b241aa3e4dcca369507f66f216dd9'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libxcb'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
