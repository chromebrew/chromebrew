require 'package'

class Inetutils < Package
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  version '1.9.4'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/inetutils/inetutils-1.9.4.tar.xz'
  source_sha256 '849d96f136effdef69548a940e3e0ec0624fc0c81265296987986a0dd36ded37'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-1.9.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-1.9.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-1.9.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-1.9.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1e73a23be24567bea04d3edbf7181abdd4cb587b3464b80ca60326031fb439d4',
     armv7l: '1e73a23be24567bea04d3edbf7181abdd4cb587b3464b80ca60326031fb439d4',
       i686: 'd48d51bd0cfe7ff943280655446981d6ad97edc75038eb507f3d74ebb38fc7d0',
     x86_64: '58c0f0a5e7d25b7b2b1c527cb38eeaa337894fab4b4151dc2e0605c9f87d2ed5',
  })

  depends_on 'buildessential'
  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} \
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
