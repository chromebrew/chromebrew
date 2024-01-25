require 'package'

class Openconnect < Package
  version '8.20'
  description 'OpenConnect is an SSL VPN client initially created to support Cisco\'s AnyConnect SSL VPN.'
  homepage 'http://www.infradead.org/openconnect/'
  license 'LGPL-2.1 and GPL-2'
  compatibility 'all'
  source_url 'https://www.infradead.org/openconnect/download/openconnect-8.20.tar.gz'
  source_sha256 'c1452384c6f796baee45d4e919ae1bfc281d6c88862e1f646a2cc513fc44e58b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7b9c045bd2b24a6a1aacefa110c4271c22429eedf7eec1cebf057fa2898f4876',
     armv7l: '7b9c045bd2b24a6a1aacefa110c4271c22429eedf7eec1cebf057fa2898f4876',
       i686: 'db5f8d1cc5ec07af4ce4dccd22e319beaf100a1bea4dde73eacc36d73fb685cc',
     x86_64: '6f25b14be33eca8f53eb142dbda5b6df2db7c6b1dd6e5d000740e69979c7df10'
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
        sudo start shill BLOCKED_DEVICES="tun0,br0"
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
    @vpnc_stop = <<~VPNC_STOPEOF
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
