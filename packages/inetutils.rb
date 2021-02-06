require 'package'

class Inetutils < Package
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  @_ver = '2.0'
  version @_ver
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/inetutils/inetutils-#{@_ver}.tar.xz"
  source_sha256 'e573d566e55393940099862e7f8994164a0ed12f5a86c3345380842bdc124722'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-2.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-2.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-2.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '7446162e65febe771bc8c88efc9d27865e7ef0d35d03c8ca90ffd4046e7eb925',
      armv7l: '7446162e65febe771bc8c88efc9d27865e7ef0d35d03c8ca90ffd4046e7eb925',
        i686: 'ed0cd237ca49f613d3398704c9cde04f78af14113458cef775bc4908db9b3f38',
      x86_64: 'cef8fbdd17ac33c31587420b5291dd9738d5fa4849140c046bb1cce9d0861d70',
  })

  depends_on 'linux_pam'

  def self.build
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --with-krb5=#{CREW_PREFIX} \
      --with-wrap \
      --with-pam \
      --disable-rexec \
      --disable-rsh \
      --enable-encryption \
      --enable-authentication \
      --disable-servers"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
