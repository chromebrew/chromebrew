require 'package'

class Tcpflow < Package
  description 'TCP/IP packet demultiplexer'
  homepage 'https://github.com/simsong/tcpflow'
  version '1.5.0'
  source_url 'https://github.com/simsong/tcpflow/releases/download/tcpflow-1.5.0/tcpflow-1.5.0.tar.gz'
  source_sha256 '20abe3353a49a13dcde17ad318d839df6312aa6e958203ea710b37bede33d988'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'boost'
  depends_on 'cairo'
  depends_on 'libpcap'

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
