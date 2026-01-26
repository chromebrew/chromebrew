require 'buildsystems/autotools'

class Inetutils < Autotools
  description 'The Inetutils package contains programs for basic networking. Such as dnsdomainname, ftp, hostname, ifconfig, ping, ping6, talk, telnet, tftp, traceroute'
  homepage 'https://www.gnu.org/software/inetutils/'
  version '2.7'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/inetutils.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f777bafbe05d22eb95a209022240480d8e0035a1c679a3ae7f69b8c3fca11c51',
     armv7l: 'f777bafbe05d22eb95a209022240480d8e0035a1c679a3ae7f69b8c3fca11c51',
       i686: '8132b26c8d8bf555fe5b101760c5e9e5574dc1a397cd0d9398b205c9d9dda629',
     x86_64: '515af1f9004aaf426c1f5d280144c75537174aa221c3e4e9cddd81bdc2e42f18'
  })

  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libxcrypt' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R

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
