require 'package'

class Transmission < Package
  description 'A fast, easy, and free BitTorrent client. https://transmissionbt.com/'
  homepage 'https://github.com/transmission/transmission-releases'
  version '2.93'
  source_url 'https://github.com/transmission/transmission-releases/raw/master/transmission-2.93.tar.xz'
  source_sha256 '8815920e0a4499bcdadbbe89a4115092dab42ce5199f71ff9a926cfd12b9b90b'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'libevent'
  depends_on 'openssl'
  depends_on 'miniupnpc'
  depends_on 'curl'
  depends_on 'zlibpkg'
  depends_on 'glib'
  depends_on 'rtmpdump'
  depends_on 'ctorrent'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
