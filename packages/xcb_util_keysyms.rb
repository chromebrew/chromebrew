require 'package'

class Xcb_util_keysyms < Package
  description 'The xcb-util-keysyms package contains a library for handling standard X key constants and conversion to/from keycodes.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.0'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-keysyms-0.4.0.tar.bz2'
  source_sha256 '0ef8490ff1dede52b7de533158547f8b454b241aa3e4dcca369507f66f216dd9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_keysyms-0.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_keysyms-0.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_keysyms-0.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_util_keysyms-0.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5b762804af0c1cda419771f9b3fe0be115f5745b163f966ed0d0be0662532e33',
     armv7l: '5b762804af0c1cda419771f9b3fe0be115f5745b163f966ed0d0be0662532e33',
       i686: '0350ac70ea2b52b02ef3b044e732972bdee62702c9ae6ba86bc1b955fbd7777e',
     x86_64: '97059f05132bfc7c5238711bc0877017f6354596e40849370252a3b519478581',
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
