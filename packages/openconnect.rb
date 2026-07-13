require 'buildsystems/autotools'

class Openconnect < Autotools
  description 'OpenConnect is an SSL VPN client initially created to support Cisco\'s AnyConnect SSL VPN.'
  homepage 'http://www.infradead.org/openconnect/'
  version '9.21'
  license 'LGPL-2.1 and GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.infradead.org/openconnect/download/openconnect-#{version}.tar.gz"
  source_sha256 '5b32369467db6e5f317aa1ed12cfcbb81ed00bdbc765450b6bfcbdc300944a58'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '666a60ad6bee25b503cef097c3dbea7af12966525093381d53e02f383f5b13f6',
     armv7l: '666a60ad6bee25b503cef097c3dbea7af12966525093381d53e02f383f5b13f6',
     x86_64: 'f4f24bbf6bf0b920872180d5460ec4899596862e9778e1f52745331fdca51846'
  })

  depends_on 'brotli' => :library
  depends_on 'e2fsprogs' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'gnutls' => :library
  depends_on 'krb5' => :library
  depends_on 'libidn2' => :library
  depends_on 'libproxy' => :library
  depends_on 'libtasn1' => :library
  depends_on 'libunistring' => :library
  depends_on 'libxml2' => :library
  depends_on 'lz4' => :library
  depends_on 'nettle' => :library
  depends_on 'p11kit' => :library
  depends_on 'vpnc' => :logical
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  print_source_bashrc

  autotools_configure_options "--with-vpnc-script=#{CREW_PREFIX}/etc/vpnc/vpnc-script"

  autotools_build_extras do
    File.write 'vpnc-start', <<~'VPNC_STARTEOF'
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
    File.write 'vpnc-stop', <<~VPNC_STOPEOF
      #!/bin/bash
      killall openconnect
      sudo ip tuntap del mode tun tun0
    VPNC_STOPEOF
    File.write '10-vpnc-start', <<~VPNC_EOF
      #!/bin/bash
      vpnc-start
    VPNC_EOF
  end

  autotools_install_extras do
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install 'vpnc-start', "#{CREW_DEST_PREFIX}/bin/vpnc-start", mode: 0o755
    FileUtils.install 'vpnc-stop', "#{CREW_DEST_PREFIX}/bin/vpnc-stop", mode: 0o755
    FileUtils.install '10-vpnc-start', "#{CREW_DEST_PREFIX}/etc/bash.d/10-vpnc-start", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      Added the following bash scripts:
      vpnc-start - start vpn
      vpnc-stop - stop vpn

      Edit #{CREW_PREFIX}/etc/bash.d/10-vpnc-start and add the domain to launch on start up.
    EOM
  end
end
