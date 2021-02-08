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
    aarch64: '8e4e1d3e987ed40aa8c63a8a794f1fd74ce390aee6e63795cb1936ff36ffd176',
     armv7l: '8e4e1d3e987ed40aa8c63a8a794f1fd74ce390aee6e63795cb1936ff36ffd176',
       i686: '7553ad07ca3e4994469efd85d7b48cbcf1d375fde0cc07495cb9cf8dabfe564d',
     x86_64: 'ad1bf386ab4ecc3d1f799c845b4f4b9451039fc0608d0ed5dcae15410815e265'
  })

  depends_on 'linux_pam'
  depends_on 'patchelf'
  depends_on 'libcap'

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
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/ping", "#{CREW_DEST_PREFIX}/bin/ping.elf", mode: 0o755
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/ping6", "#{CREW_DEST_PREFIX}/bin/ping6.elf", mode: 0o755
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/traceroute", "#{CREW_DEST_PREFIX}/bin/traceroute.elf", mode: 0o755
    PING_SH = <<EOF
#!/bin/bash
sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
    --keep=1 --user=nobody --addamb=cap_net_raw -- \\
    -c "#{CREW_PREFIX}/bin/ping.elf \$@"
EOF
IO.write("#{CREW_DEST_PREFIX}/bin/ping", PING_SH, perm: 0755)
    PING6_SH = <<EOF
#!/bin/bash
sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
    --keep=1 --user=nobody --addamb=cap_net_raw -- \\
    -c "#{CREW_PREFIX}/bin/ping6.elf \$@"
EOF
IO.write("#{CREW_DEST_PREFIX}/bin/ping6", PING6_SH, perm: 0755)
    TRACEROUTE_SH = <<EOF
#!/bin/bash
sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
    --keep=1 --user=nobody --addamb=cap_net_raw -- \\
    -c "#{CREW_PREFIX}/bin/traceroute.elf \$@"
EOF
IO.write("#{CREW_DEST_PREFIX}/bin/traceroute", TRACEROUTE_SH, perm: 0755)
  end
end
