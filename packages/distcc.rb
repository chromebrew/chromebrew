# Adapted from Arch Linux distcc PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/distcc/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/autotools'

class Distcc < Autotools
  description 'Distributed compilation service for C, C++ and Objective-C'
  homepage 'https://github.com/distcc/distcc'
  version '3.4-b83dd2e-py3.12'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/distcc/distcc.git'
  git_hashtag 'b83dd2e5450c9526e5e2bb2c8bb1e6e425ae7498'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '780193b14b43cdd3a237b3bab1502594b775b5b68730b0b5bd2f72faca23e0d4',
     armv7l: '780193b14b43cdd3a237b3bab1502594b775b5b68730b0b5bd2f72faca23e0d4',
       i686: '95f6ec2a6334aa7e6017c50c32ab26cb9adfebdff02dcac4419543169beb8aaf',
     x86_64: '0445d6d16d5a62f1802fd58e008ed27258e1e1b3484b7bba1c01f67c5148e8a6'
  })

  depends_on 'avahi' # R
  depends_on 'ccache' # L
  depends_on 'gcc_dev' # L
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'llvm18_dev' # L
  depends_on 'llvm18_lib' # R
  depends_on 'nss_mdns' # R
  depends_on 'popt' # R
  depends_on 'python3' => :build
  depends_on 'zlibpkg' # R

  def self.patch
    system "sed -i 's/ install-gnome-data//g' Makefile.in"
  end

  pre_configure_options "CFLAGS+=' -DPY_SSIZE_T_CLEAN -fcommon' NATIVE_COMPILER_TRIPLE='#{CREW_TGT}' INCLUDESERVER_PYTHON='#{CREW_PREFIX}/bin/python3'"
  configure_options '--enable-rfc2553 --disable-Werror --with-python-sys-prefix'

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} INCLUDESERVER_PYTHON=#{CREW_PREFIX}/bin/python3 install"
    # Package symlinks into lib/distcc, not ARCH_LIB/distcc, since that
    # is where distcc looks.
    @distcc_destbin_path = File.join(CREW_DEST_PREFIX, 'lib/distcc/bin')
    puts "@distcc_destbin_path is #{@distcc_destbin_path}"
    FileUtils.mkdir_p @distcc_destbin_path
    @gcc_version = `gcc -dumpversion`.chomp
    @clang_version = `clang --version|grep version|cut -d " " -f3|cut -d'.' -f1`.chomp
    distcc_gcc_targets = %W[c++ c89 c99 cc cpp g++ gcc #{CREW_TGT}-g++ #{CREW_TGT}-gcc #{CREW_TGT}-gcc-#{@gcc_version}]
    distcc_clang_targets = %W[clang clang++ clang-#{@clang_version} clang++-#{@clang_version}]
    File.write 'gcc-wrapper', <<~GCC_WRAPPEREOF
      #!/bin/bash
      if `which ccache &>/dev/null` ; then#{' '}
        exec ccache distcc #{CREW_PREFIX}/bin/#{CREW_TGT}-g${0:$[-2]} "$@"
      else
        exec distcc #{CREW_PREFIX}/bin/#{CREW_TGT}-g${0:$[-2]} "$@"
      fi
    GCC_WRAPPEREOF
    FileUtils.install 'gcc-wrapper', "#{@distcc_destbin_path}/gcc-wrapper", mode: 0o755
    # File.write 'clang-wrapper', <<~CLANG_WRAPPEREOF
    #  #!/bin/bash
    #  exec #{CREW_TGT}-$(basename ${0}) "$@"
    # CLANG_WRAPPEREOF
    # FileUtils.install 'clang-wrapper', "#{@distcc_destbin_path}/clang-wrapper", mode: 0o755
    distcc_clang_targets.each do |bin|
      Dir.chdir @distcc_destbin_path do
        FileUtils.rm bin if File.file?(bin)
      end
    end
    File.write 'clang', <<~CLC_EOF
      #!/bin/bash
      machine=$(#{CREW_PREFIX}/bin/gcc -dumpmachine)
      version=$(#{CREW_PREFIX}/bin/gcc -dumpversion)
      gnuc_lib=#{CREW_LIB_PREFIX}/gcc/${machine}/${version}
      if `which ccache &>/dev/null` ; then
        exec ccache distcc #{CREW_PREFIX}/bin/clang -B ${gnuc_lib} "$@"
      else
        exec distcc #{CREW_PREFIX}/bin/clang -B ${gnuc_lib} "$@"
      fi
    CLC_EOF
    FileUtils.install 'clang', "#{@distcc_destbin_path}/clang", mode: 0o755
    FileUtils.install 'clang', "#{@distcc_destbin_path}/clang-#{@clang_version}", mode: 0o755
    File.write 'clang++', <<~CLCPLUSPLUS_EOF
      #!/bin/bash
      machine=$(#{CREW_PREFIX}/bin/gcc -dumpmachine)
      version=$(#{CREW_PREFIX}/bin/gcc -dumpversion)
      cxx_sys=#{CREW_PREFIX}/include/c++/${version}
      cxx_inc=#{CREW_PREFIX}/include/c++/${version}/${machine}
      gnuc_lib=#{CREW_LIB_PREFIX}/gcc/${machine}/${version}
      if `which ccache &>/dev/null` ; then
        exec ccache distcc #{CREW_PREFIX}/bin/clang++ -cxx-isystem ${cxx_sys} -I ${cxx_inc} -B ${gnuc_lib} "$@"
      else
        exec distcc #{CREW_PREFIX}/bin/clang++ -cxx-isystem ${cxx_sys} -I ${cxx_inc} -B ${gnuc_lib} "$@"
      fi
    CLCPLUSPLUS_EOF
    FileUtils.install 'clang++', "#{@distcc_destbin_path}/clang++", mode: 0o755
    FileUtils.install 'clang++', "#{@distcc_destbin_path}/clang++-#{@clang_version}", mode: 0o755
    distcc_gcc_targets.each do |bin|
      Dir.chdir @distcc_destbin_path do
        FileUtils.rm bin if File.file?(bin)
        FileUtils.ln_s 'gcc-wrapper', bin
      end
    end
    File.write 'distccd.conf.d', <<~DISTCCD_CONF_D_EOF
      #
      # Parameters to be passed to distccd
      #
      # You must explicitly add IPs (or subnets) that are allowed to connect,
      # using the --allow switch.  See the distccd manpage for more info.
      #
      #DISTCC_ARGS="--allow 192.168.0.0/24 --log-level error --log-file /tmp/distccd.log"
    DISTCCD_CONF_D_EOF
    FileUtils.install 'distccd.conf.d', "#{CREW_DEST_PREFIX}/etc/conf.d/distccd.default", mode: 0o644
    File.write 'start_distccd', <<~START_DISTCCDEOF
      #!/bin/bash
      if [[ $(pgrep -wc distccd) > 1 ]]; then
        # distccd is already running.
        # Return or exit depending upon whether script was sourced.
        (return 0 2>/dev/null) && return 0 || exit 0
      fi
      ALLOWEDNETS=
      DISTCC_ARGS=
      source "#{CREW_PREFIX}/etc/conf.d/distccd.default"
      for subnet in $(ip -o -f inet addr show | awk '/scope global/ {print $4}')
      do
        DISTCC_ARGS+=" --allow $subnet "
        ALLOWEDNETS+=" $subnet "
        echo "Enabling distccd on subnet $subnet ..."
      done
      LISTENER="127.0.0.1"
      DISTCC_ARGS+=" --listen 127.0.0.1 "
      LOCALIP="$(ip route get 1 | awk '{print $7;exit}')"
      LISTENER+=" $LOCALIP "
      DISTCC_ARGS+=" --listen $LOCALIP "
      for netaddress in $(ip -o -f inet addr show | awk '/scope global/ {print $4}')
      do
        address="${netaddress%/*}"
        LISTENER+=" $address "
      done
      DISTCC_ARGS+="-N 20 ‐‐allow‐private --allow fd00::/8 --enable-tcp-insecure --log-level error --log-file #{CREW_PREFIX}/var/log/distccd.log"
      mkdir -p #{CREW_PREFIX}/var/log && touch #{CREW_PREFIX}/var/log/distccd.log
      (#{CREW_PREFIX}/bin/distccd --daemon $DISTCC_ARGS &> #{CREW_PREFIX}/var/log/distccd.log &)
      echo "Distcc hosts:"
      distcc --show-hosts
    START_DISTCCDEOF
    FileUtils.install 'start_distccd', "#{CREW_DEST_PREFIX}/bin/startdistccd", mode: 0o755
    File.write 'stop_distccd', <<~STOP_DISTCCDEOF
      #!/bin/bash
      killall -9 distccd
    STOP_DISTCCDEOF
    FileUtils.install 'stop_distccd', "#{CREW_DEST_PREFIX}/bin/stopdistccd", mode: 0o755
    # start distccd from bash.d, which loads after all of env.d via #{CREW_PREFIX}/etc/profile
    File.write 'bashd_distccd', <<~BASHDDISTCCD_EOF
      [[ $(pgrep -wc distccd) > 1 ]] || source #{CREW_PREFIX}/bin/startdistccd
    BASHDDISTCCD_EOF
    FileUtils.install 'bashd_distccd', "#{CREW_DEST_PREFIX}/etc/bash.d/distccd", mode: 0o644
    File.write 'env.d_distccd', <<~ENVDDISTCCD_EOF
      PATH=#{CREW_PREFIX}/lib/distcc/bin:$PATH
      ALLOWEDNETS='127.0.0.1/8'
      # DISTCC_VERBOSE=1
      DISTCC_JOBS=`distcc -j`
      DISTCC_DIR=#{CREW_PREFIX}/tmp/.distcc
      mkdir -p $DISTCC_DIR
      STARTDISTCC='true'
    ENVDDISTCCD_EOF
    FileUtils.install 'env.d_distccd', "#{CREW_DEST_PREFIX}/etc/env.d/distccd", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "The distcc daemon will be automatically started, but can be stopped with 'stopdistccd' and restarted with 'startdistccd'. Distcc build server IPs should be added to: #{CREW_PREFIX}/etc/distcc/hosts"
  end
end
