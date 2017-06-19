require 'package'

class Inetutils < Package
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, 
ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  version '1.9.4'
  source_url 'https://ftp.gnu.org/gnu/inetutils/inetutils-1.9.4.tar.xz'
  source_sha1 '5e515cc9da142cb73bb1beda137b4c2dcf2b528c'

  depends_on 'buildessential'

  def self.build
    system "./configure --prefix=/usr/local        \
            --localstatedir=/usr/var \
            --disable-logger     \
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
