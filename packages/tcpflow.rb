require 'package'

class Tcpflow < Package
  description 'TCP/IP packet demultiplexer'
  homepage 'https://github.com/simsong/tcpflow'
  version '1.5.0'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://github.com/simsong/tcpflow/releases/download/tcpflow-1.5.0/tcpflow-1.5.0.tar.gz'
    source_sha256 '20abe3353a49a13dcde17ad318d839df6312aa6e958203ea710b37bede33d988'
    depends_on 'boost'
    depends_on 'cairo'
    depends_on 'libpcap'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcpflow-1.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcpflow-1.5.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcpflow-1.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '080ce34873a9d15239a61117c58124946187278d39f0c432928e5dd70a919d59',
     armv7l: '080ce34873a9d15239a61117c58124946187278d39f0c432928e5dd70a919d59',
     x86_64: 'c30c853d77b7111d2f03af13b605e430d24f16fa4ea4349288ebe63488fd4fc6',
  })

  def self.build
    system './configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
