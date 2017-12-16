require 'package'

class Miniupnpc < Package
  description 'UPnP IGD client lightweight library'
  homepage 'http://miniupnp.free.fr/'
  version '2.0.20171212-1'
  source_url 'http://miniupnp.free.fr/files/download.php?file=miniupnpc-2.0.20171212.tar.gz'
  source_sha256 'cef135ae46c12358a485e809619c01145238aceb10e6e8e2946ae40c4dbe477d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/miniupnpc-2.0.20171212-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/miniupnpc-2.0.20171212-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/miniupnpc-2.0.20171212-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/miniupnpc-2.0.20171212-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2ad619aa0e291c2fd61ce5a42367e21221a0a330986102ad16355a805ba45cdd',
     armv7l: '2ad619aa0e291c2fd61ce5a42367e21221a0a330986102ad16355a805ba45cdd',
       i686: '9821f66ae49937a0b6bb3a759632e3cc545707c4f3a68fe9dcc3d293d9fba6e5',
     x86_64: '1578fc098850bca69aba3aab589651733c2332128e4e88ec309e17bd4a8d4a07',
  })

  def self.build
    system "sed -i '139s,/usr,,' Makefile"
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}"
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
