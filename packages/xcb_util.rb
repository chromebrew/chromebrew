require 'package'

class Xcb_util < Package
  description 'The xcb-util package provides additional extensions to the XCB library.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.0-1'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-0.4.0.tar.bz2'
  source_sha256 '46e49469cb3b594af1d33176cd7565def2be3fa8be4371d62271fabb5eae50e9'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '4030acacf2ffdade30af61d834b64b72c03def81cf2137115023d85f77fc7355',
     armv7l: '4030acacf2ffdade30af61d834b64b72c03def81cf2137115023d85f77fc7355',
       i686: '88d247fc1caeb4e5e19feb42ea795a7e5e0d54db529deaa5c182b9efdbceeecb',
     x86_64: 'bc0d5f03baf0f4d771f5fee8c860321fc62ec50972410d7586a34c5f9d4f4689'
  })

  depends_on 'libxcb'
  depends_on 'util_macros'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
