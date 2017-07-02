require 'package'

# @todo: provide vpnc-script (standalone), instructions for manual install:
#
# sudo su -
# mkdir /usr/local/etc/vpnc
# cd /usr/local/etc/vpnc
# wget http://git.infradead.org/users/dwmw2/vpnc-scripts.git/blob_plain/HEAD:/vpnc-script
# chmod a+x vpnc-script
# exit

# @todo: provide start-vpn script, instructions for manual connect:

# Usage (as root - run 'sudo su -'):
#
# Create 'tun0' tunnel interface:
#
# > ip tuntap add mode tun tun0
#
# Run openconnect on tun0 interface
#
# > openconnect -i tun0 vpn.example.com
# (Press Ctrl+C to exit)
#
# Shut down tun0 interface
#
# > ip tuntap del mode tun tun0

class Openconnect < Package
  version '7.06-1'
  description 'OpenConnect is an SSL VPN client initially created to support Cisco\'s AnyConnect SSL VPN.'
  homepage 'http://www.infradead.org/openconnect/'
  source_url 'ftp://ftp.infradead.org/pub/openconnect/openconnect-7.06.tar.gz'
  source_sha256 'facf695368dc4537a6a30e2147be90b1d77ee3cb2d269eaef070b6d9ddab70f2'

  depends_on 'buildessential'
  depends_on 'libxml2'
  depends_on 'gnutls'

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --with-vpnc-script=/usr/local/etc/vpnc/vpnc-script"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
