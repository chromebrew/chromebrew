require 'package'

class Xcb_util_image < Package
  description 'The xcb-util-image package provides additional extensions to the XCB library.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.0-1'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-image-0.4.0.tar.bz2'
  source_sha256 '2db96a37d78831d643538dd1b595d7d712e04bdccf8896a5e18ce0f398ea2ffc'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '5b98d3f85937bfe7f272b7ab39406ee4a645c583a0792fded18e74a82603769e',
     armv7l: '5b98d3f85937bfe7f272b7ab39406ee4a645c583a0792fded18e74a82603769e',
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
