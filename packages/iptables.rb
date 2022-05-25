require 'package'

class Iptables < Package
  description 'iptables is the userspace command line program used to configure the Linux 2.4.x and later packet filtering ruleset.'
  homepage 'https://www.netfilter.org/projects/iptables/'
  version '1.8.8'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://www.netfilter.org/projects/iptables/files/iptables-1.8.8.tar.bz2'
  source_sha256 '71c75889dc710676631553eb1511da0177bbaaf1b551265b912d236c3f51859f'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iptables/1.8.8_armv7l/iptables-1.8.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iptables/1.8.8_armv7l/iptables-1.8.8-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iptables/1.8.8_x86_64/iptables-1.8.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e13ddd61cf7c2bc5428ebc87c3723818982e21ba53527bc98b7e55a5f68eb6fa',
     armv7l: 'e13ddd61cf7c2bc5428ebc87c3723818982e21ba53527bc98b7e55a5f68eb6fa',
     x86_64: '64356d6f62e37dd77ec2c5953cc20b9fe6280623145c184fc5896b184a6317ff'
  })

  depends_on 'glibc' # R

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
