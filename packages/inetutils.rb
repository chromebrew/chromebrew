require 'package'

class Inetutils < Package
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  version '1.9.4'
  source_url 'https://ftp.gnu.org/gnu/inetutils/inetutils-1.9.4.tar.xz'
  source_sha256 '849d96f136effdef69548a940e3e0ec0624fc0c81265296987986a0dd36ded37'

  depends_on 'buildessential'
  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=/usr/local \
            --localstatedir=/usr/var \
            --disable-logger     \
            --disable-traceroute \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
