require 'package'

class Openconnect < Package
  version '8.20'
  description 'OpenConnect is an SSL VPN client initially created to support Cisco\'s AnyConnect SSL VPN.'
  homepage 'http://www.infradead.org/openconnect/'
  license 'LGPL-2.1 and GPL-2'
  compatibility 'all'
  source_url 'https://www.infradead.org/openconnect/download/openconnect-8.20.tar.gz'
  source_sha256 'c1452384c6f796baee45d4e919ae1bfc281d6c88862e1f646a2cc513fc44e58b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openconnect/8.20_armv7l/openconnect-8.20-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openconnect/8.20_armv7l/openconnect-8.20-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openconnect/8.20_i686/openconnect-8.20-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openconnect/8.20_x86_64/openconnect-8.20-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bb45e718b9914acf5f1889b626a917dec49b0c8285e5eb58af65607e0edf621e',
     armv7l: 'bb45e718b9914acf5f1889b626a917dec49b0c8285e5eb58af65607e0edf621e',
       i686: '97f6762dc14e2c81a4a71f82d86088977f2a4480083dc6bb645c173b4f173d25',
     x86_64: '582987c2bfd9b7339b82cb062b7d0cf2b0ded671215d11b248fd503442734681'
  })

  depends_on 'libproxy'
  depends_on 'libxml2'
  depends_on 'lz4'
  depends_on 'gnutls'
  depends_on 'vpnc'

  def self.build
    system "./configure \
           #{CREW_OPTIONS} \
           --with-vpnc-script=#{CREW_PREFIX}/etc/vpnc/vpnc-script"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    @vpnc_start = <<~'VPNC_STARTEOF'
      #!/bin/bash
      if test "$1"; then
        echo "Restarting ChromeOS shill process such that it does not kill the vpn network device."
        sudo stop shill
        sudo start shill BLACKLISTED_DEVICES="tun0,br0"
        timeout=10
        echo "Sleeping $timeout seconds to allow ChromeOS to reconnect to the network."
        while [ $timeout -gt 0 ]; do
           echo -ne "$timeout\033[0K\r"
           sleep 1
           ((timeout--))
        done
        sudo ip tuntap add mode tun tun0
        read -r -p "VPN Username: " USER
        read -r -s -p "VPN Password: " PASS
        echo "$PASS" | openconnect --user="$USER" --interface=tun0 -b "$1"
      else
        echo "Usage: vpnc-start vpn.example.com"
      fi
    VPNC_STARTEOF
    File.write "#{CREW_DEST_PREFIX}/bin/vpnc-start", @vpnc_start, perm: 0o755
    @vpnc_stop = <<~'VPNC_STOPEOF'
      #!/bin/bash
      killall openconnect
      sudo ip tuntap del mode tun tun0
    VPNC_STOPEOF
    File.write "#{CREW_DEST_PREFIX}/bin/vpnc-stop", @vpnc_stop, perm: 0o755
  end

  def self.postinstall
    puts
    puts 'Added the following bash scripts:'.lightblue
    puts 'vpnc-start - start vpn'.lightblue
    puts 'vpnc-stop - stop vpn'.lightblue
    puts
  end
end
