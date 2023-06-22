require 'package'

class Inetutils < Package
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  version '2.2'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/inetutils/inetutils-#{version}.tar.xz"
  source_sha256 'd547f69172df73afef691a0f7886280fd781acea28def4ff4b4b212086a89d80'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inetutils/2.2_i686/inetutils-2.2-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inetutils/2.2_armv7l/inetutils-2.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inetutils/2.2_armv7l/inetutils-2.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inetutils/2.2_x86_64/inetutils-2.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: 'ee0f7e82efe8fee69a27bda30a6d42d2a616bcd5d9be1682cec43136f70f9b71',
    aarch64: '413181b35983017b30a53f08de729ffb7f4dd54a2fdbb6b6d0d4dc7fa4333c76',
     armv7l: '413181b35983017b30a53f08de729ffb7f4dd54a2fdbb6b6d0d4dc7fa4333c76',
     x86_64: '4b6d96a0e618da13d6225d3f14f22739e6c199e944820dacbf99175ec88982df'
  })

  depends_on 'linux_pam'
  depends_on 'patchelf' => :build
  depends_on 'libcap'

  def self.build
    # logger conflicts with util_linux
    system "env #{CREW_ENV_OPTIONS.sub("CFLAGS='", "CFLAGS='-lpthread -ltinfo ")} \
      LIBRARY_PATH=#{CREW_LIB_PREFIX} ./configure #{CREW_OPTIONS} \
      --with-krb5=#{CREW_PREFIX} \
      --disable-rpath \
      --with-wrap \
      --with-pam \
      --disable-rexec \
      --disable-rsh \
      --enable-encryption \
      --enable-authentication \
      --disable-servers \
      --disable-logger"
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
    @PING_SH = <<~PING_HEREDOC
      #!/bin/bash
      sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
          --keep=1 --user=nobody --addamb=cap_net_raw -- \\
          -c "#{CREW_PREFIX}/bin/ping.elf \$@"
    PING_HEREDOC
    File.write("#{CREW_DEST_PREFIX}/bin/ping", @PING_SH, perm: 0o755)
    @PING6_SH = <<~PING6_HEREDOC
      #!/bin/bash
      sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
          --keep=1 --user=nobody --addamb=cap_net_raw -- \\
          -c "#{CREW_PREFIX}/bin/ping6.elf \$@"
    PING6_HEREDOC
    File.write("#{CREW_DEST_PREFIX}/bin/ping6", @PING6_SH, perm: 0o755)
    @TRACEROUTE_SH = <<~TRACEROUTE_HEREDOC
      #!/bin/bash
      sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
          --keep=1 --user=nobody --addamb=cap_net_raw -- \\
          -c "#{CREW_PREFIX}/bin/traceroute.elf \$@"
    TRACEROUTE_HEREDOC
    File.write("#{CREW_DEST_PREFIX}/bin/traceroute", @TRACEROUTE_SH, perm: 0o755)
  end
end
