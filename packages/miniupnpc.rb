require 'package'

class Miniupnpc < Package
  description 'UPnP IGD client lightweight library'
  homepage 'http://miniupnp.free.fr/'
  version '2.0'
  source_url 'http://miniupnp.free.fr/files/download.php?file=miniupnpc-2.0.tar.gz'
  source_sha256 'd434ceb8986efbe199c5ca53f90ed53eab290b1e6d0530b717eb6fa49d61f93b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/miniupnpc-2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/miniupnpc-2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/miniupnpc-2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/miniupnpc-2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4d2540a3b8465f16d54a74aa8fb3aee103f28a24e6e0800049c19f4ac116619a',
     armv7l: '4d2540a3b8465f16d54a74aa8fb3aee103f28a24e6e0800049c19f4ac116619a',
       i686: '061732c34b114a957b2eede570e0aee3b468e3c94600fc52902aec04a1ddc7cd',
     x86_64: '6092ef9f6538f1403c904c349535cd2bddedfd27fe8e7e7b39627c3518b8bf44',
  })

  def self.build
    system "sed -i '139s,/usr,,' Makefile"
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}"
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
