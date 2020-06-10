require 'package'

class Tcpstat < Package
  description 'tcpstat reports certain network interface statistics much like vmstat does for system statistics. tcpstat gets its information by either monitoring a specific interface, or by reading previously saved tcpdump data from a file.'
  homepage 'http://www.frenchfries.net/paul/tcpstat/'
  version '1.5'
  compatibility 'all'
  source_url 'https://web.archive.org/web/20160504233625/http://www.frenchfries.net/paul/tcpstat/tcpstat-1.5.tar.gz'
  source_sha256 '46fde9458cc5678264b0c5f2197f84ada9101951197fdeec5f04b0801fcff0ba'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcpstat-1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcpstat-1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcpstat-1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcpstat-1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9dc536b86bc7e6c133931ef586b8229386ab8528e6eea8ecfb12c8ba79ad349b',
     armv7l: '9dc536b86bc7e6c133931ef586b8229386ab8528e6eea8ecfb12c8ba79ad349b',
       i686: '7dfa94e3e50cc0be28aab02fb65fe5d43b2ce92d5961a4ce8e569b1035c032b0',
     x86_64: 'e684114ddcf7733f9650d2998a02d5ec93bb07bbb612151e74dd323017538d34',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
