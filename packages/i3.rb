require 'package'

class I3 < Package
  description 'Improved tiling window manager'
  homepage 'https://i3wm.org/'
  version '4.18.2'
  compatibility 'all'
  source_url 'https://i3wm.org/downloads/i3-4.18.2.tar.bz2'
  source_sha256 'b28617d62f308b93817fc9949daffee74cf4a001685de389f3072cb44cf5120c'  
  
  depends_on 'libev'
  depends_on 'startup_notification'
  depends_on 'xcb_util_cursor'
  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util_wm'
  depends_on 'xcb_util_xrm'
  depends_on 'yajl'
  depends_on 'wayland' => :build
  depends_on 'sommelier'
  
  def self.build
    system "./configure #{CREW_OPTIONS} --disable-builddir"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
