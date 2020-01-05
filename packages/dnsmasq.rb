require 'package'

class Dnsmasq < Package
  description 'Lightweight, easy to configure DNS forward ,TFTP server and DHCP server'
  homepage 'http://www.thekelleys.org.uk/dnsmasq/doc.html'
  version '2.80'
  source_url 'http://thekelleys.org.uk/dnsmasq/dnsmasq-2.80.tar.xz'
  source_sha256 'cdaba2785e92665cf090646cba6f94812760b9d7d8c8d0cfb07ac819377a63bb'

  depends_on 'glibc'
  depends_on 'gmp'
  depends_on 'libidn2'
  depends_on 'nettle'
  #depends_on 'make' => :build

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
