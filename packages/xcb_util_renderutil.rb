require 'package'

class Xcb_util_renderutil < Package
  description 'The xcb-util-renderutil package provides additional extensions to the XCB library'
  homepage 'http://www.linuxfromscratch.org/blfs/view/cvs/x/xcb-util-renderutil.html'
  version '0.3.9'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-renderutil-0.3.9.tar.bz2'
  source_sha256 'c6e97e48fb1286d6394dddb1c1732f00227c70bd1bedb7d1acabefdd340bea5b'

  depends_on 'libxcb'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
