require 'buildsystems/autotools'

class Inetutils < Autotools
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  version '2.6'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/inetutils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c326018755ce8ecc004d4edc2a9fc7045b68b32934208e8ab6fbfa6298fe0672',
     armv7l: 'c326018755ce8ecc004d4edc2a9fc7045b68b32934208e8ab6fbfa6298fe0672',
       i686: '383ee756feeebac0c6d0cbb58b2d1023c09708da76e6e7e9045f0aef8bbbd1d7',
     x86_64: '73cb5f01b5ff1cb5d7035f47a74acef04bec7a56c6ea899ae87ac016d7ce35a5'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libxcrypt' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R

  def patch
    system './bootstrap.sh'
  end

  autotools_pre_configure_options "CFLAGS='-Wno-incompatible-pointer-types -Wno-implicit-function-declaration -Wno-unused-result -fno-strict-aliasing' CC='gcc -lncursesw -lpthread -ltinfow' CXX='g++ -lncursesw -lpthread -ltinfow'"
  autotools_configure_options "--with-ncurses-include-dir=#{CREW_PREFIX}/include/ncursesw \
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
    # Handle conflict with the uutils_coreutils hostname.
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/hostname", "#{CREW_DEST_PREFIX}/bin/inetutils_hostname"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man1/hostname.1", "#{CREW_DEST_MAN_PREFIX}/man1/inetutils_hostname.1"

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
