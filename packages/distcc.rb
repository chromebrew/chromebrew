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
    aarch64: 'a0117c330411feac61f15e85cd85a106be53e05a4c1feaef776dd04c76c8b7d4',
     armv7l: 'a0117c330411feac61f15e85cd85a106be53e05a4c1feaef776dd04c76c8b7d4',
       i686: '51f0950594f20ce57b4dca959669c95bf7c06ceece6c6a74e39f8e718df38a68',
     x86_64: 'a69c2a63099089493dba4a58372e2ceed656cce316dd6eca083345690cb860df'
  })

  depends_on 'avahi' # R
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

  print_source_bashrc

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
      exec distcc #{CREW_PREFIX}/bin/#{CREW_TGT}-g${0:$[-2]} "$@"
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
      exec distcc #{CREW_PREFIX}/bin/clang -B ${gnuc_lib} "$@"
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
      exec distcc #{CREW_PREFIX}/bin/clang++ -cxx-isystem ${cxx_sys} -I ${cxx_inc} -B ${gnuc_lib} "$@"
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
      DISTCC_HOSTS='+zeroconf'
      source "#{CREW_PREFIX}/etc/conf.d/distccd.default"
      for subnet in $(ip -o -f inet addr show | awk '/scope global/ {print $4}')
      do
        DISTCC_ARGS+=" --allow $subnet "
        ALLOWEDNETS+=" $subnet "
        echo "Enabling distccd on subnet $subnet ..."
      done
      DISTCC_ARGS+="-N 20 ‐‐allow‐private --allow fe80::/16 ‐‐zeroconf --enable-tcp-insecure --log-level error --log-file #{CREW_PREFIX}/var/log/distccd.log"
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
      DISTCC_VERBOSE=1
      DISTCC_DIR=#{CREW_PREFIX}/tmp/.distcc
      mkdir -p $DISTCC_DIR
    ENVDDISTCCD_EOF
    FileUtils.install 'env.d_distccd', "#{CREW_DEST_PREFIX}/etc/env.d/distccd", mode: 0o644
    File.write 'distcc_avahi_service', <<~DISTCC_AVAHI_EOF
      <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
      <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
      <service-group>
        <name replace-wildcards="yes">Distcc on %h</name>
        <service>
          <type>_distcc._tcp</type>
          <port>3632</port>
        </service>
      </service-group>
    DISTCC_AVAHI_EOF
    FileUtils.install 'distcc_avahi_service', "#{CREW_DEST_PREFIX}/etc/avahi/services/distcc.service", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "The distcc daemon will be automatically started, but can be stopped with 'stopdistccd' and restarted with 'startdistccd'."
  end
end
