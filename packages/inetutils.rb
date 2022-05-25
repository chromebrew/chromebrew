require 'buildsystems/autotools'

class Inetutils < Autotools
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  version '2.4'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/inetutils/inetutils-#{version}.tar.xz"
  source_sha256 '1789d6b1b1a57dfe2a7ab7b533ee9f5dfd9cbf5b59bb1bb3c2612ed08d0f68b2'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inetutils/2.4_armv7l/inetutils-2.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inetutils/2.4_armv7l/inetutils-2.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inetutils/2.4_i686/inetutils-2.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inetutils/2.4_x86_64/inetutils-2.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f01833856fc5199d6b116fe6c5a1ef446a0063cbaaf61b031910e29b785898c4',
     armv7l: 'f01833856fc5199d6b116fe6c5a1ef446a0063cbaaf61b031910e29b785898c4',
       i686: '135835e0aba58d421bf1a6fd6067c777429be7a862d0d3d0f341788bfe2fbb2d',
     x86_64: 'e982be9a2ecc72bb21acc17f6edcd666789c36086a998f4da2691ced76251b95'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libcap' # R
  depends_on 'linux_pam' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R

  pre_configure_options "CC='gcc -lncursesw -lpthread -ltinfow' CXX='g++ -lncursesw -lpthread -ltinfow'"
  configure_options "--with-ncurses-include-dir=#{CREW_PREFIX}/include/ncursesw \
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

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/ping", "#{CREW_DEST_PREFIX}/bin/ping.elf", mode: 0o755
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/ping6", "#{CREW_DEST_PREFIX}/bin/ping6.elf", mode: 0o755
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/traceroute", "#{CREW_DEST_PREFIX}/bin/traceroute.elf", mode: 0o755
    @PING_SH = <<~PING_HEREDOC
      #!/bin/bash
      sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
          --keep=1 --user=nobody --addamb=cap_net_raw -- \\
          -c "#{CREW_PREFIX}/bin/ping.elf $@"
    PING_HEREDOC
    File.write("#{CREW_DEST_PREFIX}/bin/ping", @PING_SH, perm: 0o755)
    @PING6_SH = <<~PING6_HEREDOC
      #!/bin/bash
      sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
          --keep=1 --user=nobody --addamb=cap_net_raw -- \\
          -c "#{CREW_PREFIX}/bin/ping6.elf $@"
    PING6_HEREDOC
    File.write("#{CREW_DEST_PREFIX}/bin/ping6", @PING6_SH, perm: 0o755)
    @TRACEROUTE_SH = <<~TRACEROUTE_HEREDOC
      #!/bin/bash
      sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
          --keep=1 --user=nobody --addamb=cap_net_raw -- \\
          -c "#{CREW_PREFIX}/bin/traceroute.elf $@"
    TRACEROUTE_HEREDOC
    File.write("#{CREW_DEST_PREFIX}/bin/traceroute", @TRACEROUTE_SH, perm: 0o755)
  end
end
