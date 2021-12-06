require 'package'

class Xcb_util_image < Package
  description 'The xcb-util-image package provides additional extensions to the XCB library.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.0-1'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-image-0.4.0.tar.bz2'
  source_sha256 '2db96a37d78831d643538dd1b595d7d712e04bdccf8896a5e18ce0f398ea2ffc'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_image/0.4.0-1_i686/xcb_util_image-0.4.0-1-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_image/0.4.0-1_x86_64/xcb_util_image-0.4.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: '8f539e6fa5753bc8bef0d873fd0a12a66e8a17fd5b61bf94b75b0268e567fe1e',
  x86_64: 'f6934d3b2cf842afb62fa1b421a29260a8fbb2be5567977661552c4a3d43d941'
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
