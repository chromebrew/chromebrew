require 'package'

class Ndisc6 < Package
  description 'Small collection of useful tools for IPv6 networking (ndisc6, rdisc6, tcptraceroute6, traceroute6, rdnssd).'
  homepage 'https://www.remlab.net/ndisc6/'
  version '1.0.3'
  source_url 'https://www.remlab.net/files/ndisc6/ndisc6-1.0.3.tar.bz2'
  source_sha256 '0f41d6caf5f2edc1a12924956ae8b1d372e3b426bd7b11eed7d38bc974eec821'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'perl'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}", "--disable-suid-install"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
