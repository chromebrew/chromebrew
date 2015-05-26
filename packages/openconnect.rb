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
# > openconnect -i tun0 vpn.monotek.net
# (Press Ctrl+C to exit)
#
# Shut down tun0 interface
#
# > ip tuntap del mode tun tun0

class Openconnect < Package
  version '7.06'
  source_url 'ftp://ftp.infradead.org/pub/openconnect/openconnect-7.06.tar.gz' # software source tarball url  
  source_sha1 '2351408693aab0c6bc97d37e68b4a869fbb217ed'

  depends_on 'buildessential'
  depends_on 'libxml2'
  depends_on 'gnutls'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure --with-vpnc-script=/usr/local/etc/vpnc/vpnc-script"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
