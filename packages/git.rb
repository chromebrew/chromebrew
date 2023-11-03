require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.42.1' # Do not use @_ver here, it will break the installer.
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.42.1.tar.xz'
  source_sha256 '8e46fa96bf35a65625d85fde50391e39bc0620d1bb39afb70b96c4a237a1a4f7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.42.1_armv7l/git-2.42.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.42.1_armv7l/git-2.42.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.42.1_i686/git-2.42.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.42.1_x86_64/git-2.42.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '32c2b530cd907343e1ce2fc8d6216ce9d6a248e5629bdf5f5e1ef18b3ae39864',
     armv7l: '32c2b530cd907343e1ce2fc8d6216ce9d6a248e5629bdf5f5e1ef18b3ae39864',
       i686: 'dd84fbba4b51a7dd234f3b8095c0664067b7ce5969a8fd61e42ee2657f31dfed',
     x86_64: '0f40d76b5876f5e396d5baf164aafde3fa54144fa470bb8bdaf0528b1f09e079'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'curl' # R
  depends_on 'expat' # R
  depends_on 'glibc' # R
  depends_on 'libunistring' # R
  depends_on 'pcre2' # R
  depends_on 'zlibpkg' # R

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
    return unless File.directory?("#{CREW_PREFIX}/lib/crew/.git")

    puts 'Running git garbage collection...'.lightblue
    system 'git gc', chdir: "#{CREW_PREFIX}/lib/crew", exception: false
  end
end
