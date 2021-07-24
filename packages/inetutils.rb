require 'package'

class Inetutils < Package
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  @_ver = '2.0'
  version "#{@_ver}-2"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/inetutils/inetutils-#{@_ver}.tar.xz"
  source_sha256 'e573d566e55393940099862e7f8994164a0ed12f5a86c3345380842bdc124722'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inetutils/2.0-2_armv7l/inetutils-2.0-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inetutils/2.0-2_armv7l/inetutils-2.0-2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inetutils/2.0-2_x86_64/inetutils-2.0-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ae1e5b394988799ecfb50197e60e1cc90fce3a0a5d91bd4a0f6d84c036164321',
     armv7l: 'ae1e5b394988799ecfb50197e60e1cc90fce3a0a5d91bd4a0f6d84c036164321',
     x86_64: 'cafa21af3d855a8fe9118e02f1e8db83e31603822ba6c5c27c380769050fb107'
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
    IO.write("#{CREW_DEST_PREFIX}/bin/ping", @PING_SH, perm: 0o755)
    @PING6_SH = <<~PING6_HEREDOC
      #!/bin/bash
      sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
          --keep=1 --user=nobody --addamb=cap_net_raw -- \\
          -c "#{CREW_PREFIX}/bin/ping6.elf \$@"
    PING6_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/bin/ping6", @PING6_SH, perm: 0o755)
    @TRACEROUTE_SH = <<~TRACEROUTE_HEREDOC
      #!/bin/bash
      sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
          --keep=1 --user=nobody --addamb=cap_net_raw -- \\
          -c "#{CREW_PREFIX}/bin/traceroute.elf \$@"
    TRACEROUTE_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/bin/traceroute", @TRACEROUTE_SH, perm: 0o755)
  end
end
