require 'package'

class Inetutils < Package
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  @_ver = '2.0'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/inetutils/inetutils-#{@_ver}.tar.xz"
  source_sha256 'e573d566e55393940099862e7f8994164a0ed12f5a86c3345380842bdc124722'

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
    system "cat <<'EOF'> ping_
#!/bin/bash
sudo -E #{CREW_PREFIX}/sbin/capsh --caps=\"cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep\" \\
    --keep=1 --user=nobody --addamb=cap_net_raw -- \\
    -c \"#{CREW_PREFIX}/bin/ping.elf \$@\"
EOF"
    system "cat <<'EOF'> ping6_
#!/bin/bash
sudo -E #{CREW_PREFIX}/sbin/capsh --caps=\"cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep\" \\
    --keep=1 --user=nobody --addamb=cap_net_raw -- \\
    -c \"#{CREW_PREFIX}/bin/ping6.elf \$@\"
EOF"
    system "cat <<'EOF'> traceroute_
#!/bin/bash
sudo -E #{CREW_PREFIX}/sbin/capsh --caps=\"cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep\" \\
    --keep=1 --user=nobody --addamb=cap_net_raw -- \\
    -c \"#{CREW_PREFIX}/bin/traceroute.elf \$@\"
EOF"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "patchelf --set-rpath #{CREW_LIB_PREFIX} #{CREW_DEST_PREFIX}/bin/ping"
    system "patchelf --set-rpath #{CREW_LIB_PREFIX} #{CREW_DEST_PREFIX}/bin/ping6"
    system "patchelf --set-rpath #{CREW_LIB_PREFIX} #{CREW_DEST_PREFIX}/bin/traceroute"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/ping", "#{CREW_DEST_PREFIX}/bin/ping.elf"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/ping6", "#{CREW_DEST_PREFIX}/bin/ping6.elf"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/traceroute", "#{CREW_DEST_PREFIX}/bin/traceroute.elf"
    FileUtils.install 'ping_', "#{CREW_DEST_PREFIX}/bin/ping", mode: 0o755
    FileUtils.install 'ping6_', "#{CREW_DEST_PREFIX}/bin/ping6", mode: 0o755
    FileUtils.install 'traceroute_', "#{CREW_DEST_PREFIX}/bin/traceroute", mode: 0o755
  end
end
