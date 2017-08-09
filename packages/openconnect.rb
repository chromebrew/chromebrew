require 'package'

class Openconnect < Package
  version '7.08'
  description 'OpenConnect is an SSL VPN client initially created to support Cisco\'s AnyConnect SSL VPN.'
  homepage 'http://www.infradead.org/openconnect/'
  source_url 'ftp://ftp.infradead.org/pub/openconnect/openconnect-7.08.tar.gz'
  source_sha256 '1c44ec1f37a6a025d1ca726b9555649417f1d31a46f747922b84099ace628a03'

  depends_on 'buildessential'
  depends_on 'libxml2'
  depends_on 'gnutls'

  def self.build
    system "./configure CFLAGS=' -fPIC' --with-vpnc-script=#{CREW_PREFIX}/bin/vpnc-script"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_DIR}#{CREW_PREFIX}/bin") do
      system "wget http://git.infradead.org/users/dwmw2/vpnc-scripts.git/blob_plain/HEAD:/vpnc-script"
      system "chmod +x vpnc-script"
      system "echo '#!/bin/bash' > vpnc-start"
      system "echo 'if test \$1; then' >> vpnc-start"
      system "echo '  sudo ip tuntap add mode tun tun0' >> vpnc-start"
      system "echo '  read -p \"VPN Username: \" USER' >> vpnc-start"
      system "echo '  read -s -p \"VPN Password: \" PASS' >> vpnc-start"
      system "echo '  echo \"\$PASS\" | openconnect --user=\$USER --interface=tun0 -b \$1' >> vpnc-start"
      system "echo 'else' >> vpnc-start"
      system "echo '  echo \"Usage: vpnc-start vpn.example.com\"' >> vpnc-start"
      system "echo 'fi' >> vpnc-start"
      system "chmod +x vpnc-start"
      system "echo '#!/bin/bash' > vpnc-stop"
      system "echo 'killall openconnect' >> vpnc-stop"
      system "echo 'sudo ip tuntap del mode tun tun0' >> vpnc-stop"
      system "chmod +x vpnc-stop"
    end
    puts
    puts "Added the following bash scripts:".lightblue
    puts "vpnc-start - start vpn".lightblue
    puts "vpnc-stop - stop vpn".lightblue
    puts
  end
end
