require 'package'

class Xcb_util_keysyms < Package
  description 'The xcb-util-keysyms package contains a library for handling standard X key constants and conversion to/from keycodes.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.0-1'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-keysyms-0.4.0.tar.bz2'
  source_sha256 '0ef8490ff1dede52b7de533158547f8b454b241aa3e4dcca369507f66f216dd9'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_keysyms/0.4.0-1_armv7l/xcb_util_keysyms-0.4.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_keysyms/0.4.0-1_armv7l/xcb_util_keysyms-0.4.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_keysyms/0.4.0-1_i686/xcb_util_keysyms-0.4.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_keysyms/0.4.0-1_x86_64/xcb_util_keysyms-0.4.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'dc00e514a928a196fde0c698810b2f6b63b83e29e680d489d50c049aafb8ad18',
     armv7l: 'dc00e514a928a196fde0c698810b2f6b63b83e29e680d489d50c049aafb8ad18',
       i686: '5469ba85929b5eb6c0726049f5e298d531ce3b7a522ea4b8d2c1eac0d8c97913',
     x86_64: 'a5eef2ec3f6258191bfd5284f7b5fd4f2b60dcc5e40df7fff4ebc29c5e2266e8'
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
