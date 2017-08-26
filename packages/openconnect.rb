require 'package'

class Openconnect < Package
  version '7.08'
  description 'OpenConnect is an SSL VPN client initially created to support Cisco\'s AnyConnect SSL VPN.'
  homepage 'http://www.infradead.org/openconnect/'
  source_url 'ftp://ftp.infradead.org/pub/openconnect/openconnect-7.08.tar.gz'
  source_sha256 '1c44ec1f37a6a025d1ca726b9555649417f1d31a46f747922b84099ace628a03'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openconnect-7.08-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openconnect-7.08-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openconnect-7.08-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openconnect-7.08-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8e6a51bbf9a4f7025b5db6b0e638db523704e89171e109ecc987ee6cb6cbef3f',
     armv7l: '8e6a51bbf9a4f7025b5db6b0e638db523704e89171e109ecc987ee6cb6cbef3f',
       i686: '644cc95d14d27735f78ece4cd8ed2896588a5df30a232581942c03e44eeeafce',
     x86_64: '166ff91359ad64ca5a7227ec9a164096c89b46215dc92e990bf14a46ab8b851d',
  })

  depends_on 'buildessential'
  depends_on 'libxml2'
  depends_on 'gnutls'
  depends_on 'vpnc'

  def self.build
    system "./configure CFLAGS=' -fPIC' --with-vpnc-script=#{CREW_PREFIX}/etc/vpnc/vpnc-script"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_DIR}#{CREW_PREFIX}/bin") do
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
