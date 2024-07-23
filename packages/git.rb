require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.45.2' # Do not use @_ver here, it will break the installer.
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.45.2.tar.xz'
  source_sha256 '51bfe87eb1c02fed1484051875365eeab229831d30d0cec5d89a14f9e40e9adb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe8db63afdf238d52c85247e02f96c4ec5ce87f3261d5859af50cb0724ccbd56',
     armv7l: 'fe8db63afdf238d52c85247e02f96c4ec5ce87f3261d5859af50cb0724ccbd56',
       i686: '12d9fcecf4ed4d8e86b91a058a60d2cbf2f75585cfc24ffd1655042d132c138d',
     x86_64: '81ce638926071604d8559b0d8cd02ce90c4a75e7a7c61d0033e7b8e602b82e91'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'curl' # R
  depends_on 'expat' # R
  depends_on 'glibc' # R
  depends_on 'libunistring' # R
  depends_on 'pcre2' # R
  depends_on 'zlibpkg' # R

  print_source_bashrc

  def self.patch
    # Patch to prevent error function conflict with libidn2
    # By replacing all calls to error with git_error.
    system "sed -i 's,^#undef error$,#undef git_error,' usage.c"
    sedcmd = 's/\([[:blank:]]\)error(/\1git_error(/'.dump
    system "grep -rl '[[:space:]]error(' . | xargs sed -i #{sedcmd}"
    sedcmd2 = 's/\([[:blank:]]\)error (/\1git_error (/'.dump
    system "grep -rl '[[:space:]]error (' . | xargs sed -i #{sedcmd2}"
    system "grep -rl ' !!error(' . | xargs sed -i 's/ !!error(/ !!git_error(/g'"
    system "sed -i 's/#define git_error(...) (error(__VA_ARGS__), const_error())/#define git_error(...) (git_error(__VA_ARGS__), const_error())/' git-compat-util.h"
    # CMake patches.
    # Avoid undefined reference to `trace2_collect_process_info' &  `obstack_free'
    system "sed -i 's,compat_SOURCES unix-socket.c unix-stream-server.c,compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c compat/obstack.c,g' contrib/buildsystems/CMakeLists.txt"
    # The VCPKG optout in this CmakeLists.txt file is quite broken.
    system "sed -i 's/set(USE_VCPKG/#set(USE_VCPKG/g' contrib/buildsystems/CMakeLists.txt"
    system "sed -i 's,set(PERL_PATH /usr/bin/perl),set(PERL_PATH #{CREW_PREFIX}/bin/perl),g' contrib/buildsystems/CMakeLists.txt"
    system "sed -i 's,#!/usr/bin,#!#{CREW_PREFIX}/bin,g' contrib/buildsystems/CMakeLists.txt"
    # Without the following DESTDIR doesn't work.
    system "sed -i 's,${CMAKE_INSTALL_PREFIX}/bin/git,${CMAKE_BINARY_DIR}/git,g' contrib/buildsystems/CMakeLists.txt"
    system "sed -i 's,${CMAKE_INSTALL_PREFIX}/bin/git,\\\\$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/git,g' contrib/buildsystems/CMakeLists.txt"
    system "sed -i 's,${CMAKE_INSTALL_PREFIX},\\\\$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX},g' contrib/buildsystems/CMakeLists.txt"
  end

  def self.build
    system "mold -run cmake -B builddir \
        #{CREW_CMAKE_OPTIONS} \
        -DUSE_VCPKG=FALSE \
        -Wdev \
        -G Ninja \
        contrib/buildsystems"
    system "#{CREW_NINJA} -C builddir"
    git_env = <<~EOF

      GIT_PS1_SHOWDIRTYSTATE=yes
      GIT_PS1_SHOWSTASHSTATE=yes
      GIT_PS1_SHOWUNTRACKEDFILES=yes
      GIT_PS1_SHOWUPSTREAM=auto
      GIT_PS1_DESCRIBE_STYLE=default
      GIT_PS1_SHOWCOLORHINTS=yes

      PS1='\\[\\033[1;34m\\]\\u@\\H \\[\\033[1;33m\\]\\w \\[\\033[1;31m\\]$(__git_ps1 "(%s)")\\[\\033[0m\\]\\$ '
    EOF
    File.write('contrib/completion/git-prompt.sh', git_env, mode: 'a')
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/git-completion"
    FileUtils.cp_r Dir.glob('contrib/completion/.'), "#{CREW_DEST_PREFIX}/share/git-completion/"

    File.write 'git_bashd_env', <<~GIT_BASHD_EOF
      # git bash completion
      source #{CREW_PREFIX}/share/git-completion/git-completion.bash
    GIT_BASHD_EOF
    FileUtils.install 'git_bashd_env', "#{CREW_DEST_PREFIX}/etc/bash.d/git", mode: 0o644
    FileUtils.install 'contrib/completion/git-prompt.sh', "#{CREW_DEST_PREFIX}/etc/bash.d/git-prompt.sh", mode: 0o644
  end

  def self.check
    # Check to see if linking libcurl worked, which means
    # git-remote-https should exist
    unless File.symlink?("#{CREW_DEST_PREFIX}/libexec/git-core/git-remote-https") ||
           File.exist?("#{CREW_DEST_PREFIX}/libexec/git-core/git-remote-https")
      abort 'git-remote-https is broken'.lightred
    end
  end

  def self.postinstall
    ExitMessage.add "\ncd /path/to/git/repo and you should see the branch displayed in the prompt.\n".lightblue
    return unless File.directory?("#{CREW_PREFIX}/lib/crew/.git")

    puts 'Running git garbage collection...'.lightblue
    system 'git gc', chdir: "#{CREW_PREFIX}/lib/crew", exception: false
  end
end
