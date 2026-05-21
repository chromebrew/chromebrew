require 'buildsystems/autotools'

class Inetutils < Autotools
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  version '2.8'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/inetutils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51fc881644bb25560108bc7f789d03d4412d7520a492a1b398b00e225b04fb11',
     armv7l: '51fc881644bb25560108bc7f789d03d4412d7520a492a1b398b00e225b04fb11',
       i686: '0c3cc5528226d99f3fc09f684432f84a8146c97004528bb71fbbc59b5ceff596',
     x86_64: '72d7732a76dcc0a3b82b292f63d72e4fc954265847001078fa5388fd688aa186'
  })

  depends_on 'e2fsprogs' => :executable
  depends_on 'glibc' => :executable
  depends_on 'krb5' => :executable
  depends_on 'libxcrypt' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'readline' => :executable

  conflicts_ok # Some executables such as hostname are also found in uutils_coreutils.

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

  def self.prebuild
    # The c11threads threads.h breaks builds on software that uses gnulib.
    # See: https://github.com/jtsiomb/c11threads/issues/19
    # Note that c11threads is a workaround for C11 Threads only being
    # introduced in Glibc 2.28 as per:
    # https://sourceware.org/bugzilla/show_bug.cgi?id=14092#c10
    if LIBC_VERSION.to_f < 2.28 && ENV['NESTED_CI']
      puts 'Removing the c11threads include/threads.h from the c11threads package to prevent build failures.'.orange
      FileUtils.rm_f "#{CREW_PREFIX}/include/threads.h"
    end
  end

  def patch
    system './bootstrap.sh'
  end

  # def self.install
  # system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  # Handle conflict with the uutils_coreutils hostname.
  # FileUtils.mv "#{CREW_DEST_PREFIX}/bin/hostname", "#{CREW_DEST_PREFIX}/bin/inetutils_hostname"
  # FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man1/hostname.1", "#{CREW_DEST_MAN_PREFIX}/man1/inetutils_hostname.1"

  # FileUtils.install "#{CREW_DEST_PREFIX}/bin/ping", "#{CREW_DEST_PREFIX}/bin/ping.elf", mode: 0o755
  # FileUtils.install "#{CREW_DEST_PREFIX}/bin/ping6", "#{CREW_DEST_PREFIX}/bin/ping6.elf", mode: 0o755
  # FileUtils.install "#{CREW_DEST_PREFIX}/bin/traceroute", "#{CREW_DEST_PREFIX}/bin/traceroute.elf", mode: 0o755
  # @PING_SH = <<~PING_HEREDOC
  #  #!/bin/bash
  #  sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
  #      --keep=1 --user=nobody --addamb=cap_net_raw -- \\
  #      -c "#{CREW_PREFIX}/bin/ping.elf $@"
  # PING_HEREDOC
  # File.write("#{CREW_DEST_PREFIX}/bin/ping", @PING_SH, perm: 0o755)
  # @PING6_SH = <<~PING6_HEREDOC
  # #!/bin/bash
  #  sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
  #       --keep=1 --user=nobody --addamb=cap_net_raw -- \\
  #       -c "#{CREW_PREFIX}/bin/ping6.elf $@"
  # PING6_HEREDOC
  # File.write("#{CREW_DEST_PREFIX}/bin/ping6", @PING6_SH, perm: 0o755)
  # @TRACEROUTE_SH = <<~TRACEROUTE_HEREDOC
  #  #!/bin/bash
  #  sudo -E #{CREW_PREFIX}/sbin/capsh --caps='cap_net_raw+eip cap_setpcap,cap_setuid,cap_setgid+ep' \\
  #       --keep=1 --user=nobody --addamb=cap_net_raw -- \\
  #       -c "#{CREW_PREFIX}/bin/traceroute.elf $@"
  # TRACEROUTE_HEREDOC
  # File.write("#{CREW_DEST_PREFIX}/bin/traceroute", @TRACEROUTE_SH, perm: 0o755)
  # end

  def self.postinstall
    ExitMessage.add "\nMake sure to precede commands with 'sudo' to execute.\nFor example, 'sudo ping <domain>'\n"
  end
end
