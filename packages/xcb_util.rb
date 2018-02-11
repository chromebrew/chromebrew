require 'package'

class Xcb_util < Package
  description 'The xcb-util package provides additional extensions to the XCB library.'
  homepage 'http://xcb.freedesktop.org'
  version '0.4.0'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-0.4.0.tar.bz2'
  source_sha256 '46e49469cb3b594af1d33176cd7565def2be3fa8be4371d62271fabb5eae50e9'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libxcb'
  depends_on 'util_macros'


  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
