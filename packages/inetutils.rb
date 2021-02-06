require 'package'

class Inetutils < Package
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  @_ver = '2.0'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/inetutils/inetutils-#{@_ver}.tar.xz"
  source_sha256 'e573d566e55393940099862e7f8994164a0ed12f5a86c3345380842bdc124722'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-2.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-2.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-2.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/inetutils-2.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9761fd87ab7276ef701071a52cea3eed86819c4cb6a6bbd01a0062cc51a2a6d3',
     armv7l: '9761fd87ab7276ef701071a52cea3eed86819c4cb6a6bbd01a0062cc51a2a6d3',
       i686: '254bdff9f045a1909111b71c248483b86671a0564ad3fd273168ef6f1f6dc595',
     x86_64: 'bc795eea585ce49e7f041ba850450b67c74e49d9141ba1f27d58614597af208d'
  })

  depends_on 'linux_pam'
  depends_on 'patchelf'

  def self.build
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      LIBRARY_PATH=#{CREW_LIB_PREFIX} ./configure #{CREW_OPTIONS} \
      --with-krb5=#{CREW_PREFIX} \
      --disable-rpath \
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
    system "patchelf --set-rpath #{CREW_LIB_PREFIX} #{CREW_DEST_PREFIX}/bin/ping"
    system "patchelf --set-rpath #{CREW_LIB_PREFIX} #{CREW_DEST_PREFIX}/bin/ping6"
    system "patchelf --set-rpath #{CREW_LIB_PREFIX} #{CREW_DEST_PREFIX}/bin/traceroute"
  end

  def self.preinstall
    system "sudo chown chronos #{CREW_PREFIX}/bin/ping" \
      if File.exist? "#{CREW_PREFIX}/bin/ping"
    system "sudo chown chronos #{CREW_PREFIX}/bin/ping6" \
      if File.exist? "#{CREW_PREFIX}/bin/ping6"
    system "sudo chown chronos #{CREW_PREFIX}/bin/traceroute" \
      if File.exist? "#{CREW_PREFIX}/bin/traceroute"
  end

  def self.postinstall
    puts 'Settings permissions for utilities using sudo'.orange
    system "sudo chown root #{CREW_PREFIX}/bin/ping"
    system "sudo chown root #{CREW_PREFIX}/bin/ping6"
    system "sudo chown root #{CREW_PREFIX}/bin/traceroute"
    system "sudo chmod 4755 #{CREW_PREFIX}/bin/ping"
    system "sudo chmod 4755 #{CREW_PREFIX}/bin/ping6"
    system "sudo chmod 4755 #{CREW_PREFIX}/bin/traceroute"
  end
end
