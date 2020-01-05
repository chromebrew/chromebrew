require 'package'

class Dnsmasq < Package
  description 'Lightweight, easy to configure DNS forward ,TFTP server and DHCP server'
  homepage 'http://www.thekelleys.org.uk/dnsmasq/doc.html'
  version '2.80'
  source_url 'http://thekelleys.org.uk/dnsmasq/dnsmasq-2.80.tar.xz'
  source_sha256 'cdaba2785e92665cf090646cba6f94812760b9d7d8c8d0cfb07ac819377a63bb'

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
