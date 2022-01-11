require 'package'

class Iptables < Package
  description 'iptables is the userspace command line program used to configure the Linux 2.4.x and later packet filtering ruleset.'
  homepage 'https://www.netfilter.org/projects/iptables/'
  version '1.8.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.netfilter.org/projects/iptables/files/iptables-1.8.7.tar.bz2'
  source_sha256 'c109c96bb04998cd44156622d36f8e04b140701ec60531a10668cfdff5e8d8f0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iptables/1.8.7_armv7l/iptables-1.8.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iptables/1.8.7_armv7l/iptables-1.8.7-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iptables/1.8.7_i686/iptables-1.8.7-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iptables/1.8.7_x86_64/iptables-1.8.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '80ae46865b58fe834170eebe40182daf19fbe7799ef2e0ec1ed0ae3236e47a98',
     armv7l: '80ae46865b58fe834170eebe40182daf19fbe7799ef2e0ec1ed0ae3236e47a98',
       i686: '82b5ace4df5886a23853fdf5fe578dcf49e2987d2f279cdc5f95c6e82fc8c2ed',
     x86_64: '1e103594a1e9f9741a1c4dcf2d9087657c3a26dc2c6bf6f64c151a7ba51921e9'
  })

  def self.patch
    system 'filefix'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS} \
      --enable-static \
      --disable-nftables"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
