require 'package'

class Dnsmasq < Package
  description 'Lightweight, easy to configure DNS forward ,TFTP server and DHCP server'
  homepage 'http://www.thekelleys.org.uk/dnsmasq/doc.html'
  version '2.80'
  license 'GPL-2 or GPL-3'
  compatibility 'all'
  source_url 'http://thekelleys.org.uk/dnsmasq/dnsmasq-2.80.tar.xz'
  source_sha256 'cdaba2785e92665cf090646cba6f94812760b9d7d8c8d0cfb07ac819377a63bb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dnsmasq/2.80_armv7l/dnsmasq-2.80-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dnsmasq/2.80_armv7l/dnsmasq-2.80-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dnsmasq/2.80_i686/dnsmasq-2.80-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dnsmasq/2.80_x86_64/dnsmasq-2.80-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cc8c362e20af19a30faf76355ca10a3f3ec856004008c2dd0272e40957fdfc62',
     armv7l: 'cc8c362e20af19a30faf76355ca10a3f3ec856004008c2dd0272e40957fdfc62',
       i686: 'b775dbaf13731edd9875c102ac27d5887662140640258e17929aeb31030411ba',
     x86_64: '08436672bcc06753874f043ce26f5d35fb8a1588a0bf8b05d17c638cbd83394c'
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
