require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.39.2' # Do not use @_ver here, it will break the installer.
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.39.2.tar.xz'
  source_sha256 '475f75f1373b2cd4e438706185175966d5c11f68c4db1e48c26257c43ddcf2d6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.39.2_armv7l/git-2.39.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.39.2_armv7l/git-2.39.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.39.2_i686/git-2.39.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.39.2_x86_64/git-2.39.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '36c15e0db8fe5cb2e20b9b1993cdbfb3f6b3ff81330b7150b2fa75bee5c12346',
     armv7l: '36c15e0db8fe5cb2e20b9b1993cdbfb3f6b3ff81330b7150b2fa75bee5c12346',
       i686: '30436a9ec1c43a4d86780ef919a008db9ac0cb9b9370ec12b3d01dda9cf0191a',
     x86_64: 'b81daa55b5ef25f00b2684f17a111639071f75b4c7a1fe795990aa8054ae575c'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'libcurl'
  depends_on 'libunistring'
  depends_on 'pcre2'
  depends_on 'zlibpkg'
  depends_on 'expat' # R
  depends_on 'glibc' # R

  no_patchelf
  no_zstd

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
    Dir.mkdir 'contrib/buildsystems/builddir'
    Dir.chdir 'contrib/buildsystems/builddir' do
      system "mold -run cmake \
          #{CREW_CMAKE_OPTIONS} \
          -DUSE_VCPKG=FALSE \
          -Wdev \
          -G Ninja \
          .."
      system 'mold -run samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C contrib/buildsystems/builddir install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/git-completion"
    FileUtils.cp_r Dir.glob('contrib/completion/.'), "#{CREW_DEST_PREFIX}/share/git-completion/"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @git_bashd_env = <<~GIT_BASHD_EOF
      # git bash completion
      source #{CREW_PREFIX}/share/git-completion/git-completion.bash
    GIT_BASHD_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/git", @git_bashd_env)
  end

  def self.check
    # Check to see if linking libcurl worked, which means
    # git-remote-https should exist
    unless File.symlink?("#{CREW_DEST_PREFIX}/libexec/git-core/git-remote-https") ||
           File.exist?("#{CREW_DEST_PREFIX}/libexec/git-core/git-remote-https")
      abort 'git-remote-https is broken'.lightred
    end
  end
end
