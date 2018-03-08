require 'package'

class Transmission < Package
  description 'A fast, easy, and free BitTorrent client.'
  homepage 'https://transmissionbt.com/'
  version '2.93'
  source_url 'https://github.com/transmission/transmission-releases/raw/master/transmission-2.93.tar.xz'
  source_sha256 '8815920e0a4499bcdadbbe89a4115092dab42ce5199f71ff9a926cfd12b9b90b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/transmission-2.93-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/transmission-2.93-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/transmission-2.93-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/transmission-2.93-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2b02c42fe4a833742d4a53881000d851023e781f369c258237af93abfefe5e50',
     armv7l: '2b02c42fe4a833742d4a53881000d851023e781f369c258237af93abfefe5e50',
       i686: '505533e47769581f6a7cb2aed26605815551f0d21be5276c5ada38c52148c369',
     x86_64: '295cae60f1b9ff989bf3a73fdf4b6b3165ddb3382f3d8442f8a0cae7bee0fe79',
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
