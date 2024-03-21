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
    aarch64: 'b13fe326d37cea2d67ab019b8f39e2c5ee908bc0350ac94bef00665c24c0322f',
     armv7l: 'b13fe326d37cea2d67ab019b8f39e2c5ee908bc0350ac94bef00665c24c0322f',
       i686: '51dfc7d315d95e0a39854ea81b1162acd0a82b3789d90f9b8f97d99135ee1dea',
     x86_64: '0e5fc7b49b98fae285e93f5329c4a3aaa395b9216a3c80dab6c3044ddd79e1ab'
  })

  depends_on 'avahi' # R
  depends_on 'gcc_dev' # L
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'llvm18_dev' # L
  depends_on 'llvm18_lib' # R
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
    FileUtils.mkdir_p @distcc_destbin_path
    distcc_targets = %W[c++ c89 c99 cc clang clang++ cpp g++ gcc #{CREW_TGT}-g++ #{CREW_TGT}-gcc #{CREW_TGT}-gcc-$(gcc -dumpversion)]
    distcc_targets.each do |bin|
      if File.file?("#{CREW_PREFIX}/bin/#{bin}")
        puts "Creating distcc symlink for #{CREW_PREFIX}/bin/#{bin} .".orange
        FileUtils.ln_s "#{CREW_PREFIX}/bin/#{bin}", File.join(@distcc_destbin_path, bin).to_s
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
    File.write 'startdistccd', <<~START_DISTCCDEOF
      #!/bin/bash -a
      if [ -z ${START_DISTCCD+x} ]; then
        # Set env variable START_DISTCCD to enable distccd
        exit 0
      fi
      DISTCC_ARGS=
      source "#{CREW_PREFIX}/etc/conf.d/distccd.default"
      for subnet in $(ip -o -f inet addr show | awk '/scope global/ {print $4}')
      do
        DISTCC_ARGS+=" --allow $subnet "
        echo "Enabling distccd on subnet $subnet ..."
      done
      DISTCC_ARGS+="-N 20 ‐‐allow‐private ‐‐zeroconf --log-level error --log-file #{CREW_PREFIX}/var/log/distccd.log"
      mkdir -p #{CREW_PREFIX}/var/log && touch #{CREW_PREFIX}/var/log/distccd.log
      #{CREW_PREFIX}/bin/distccd --no-detach --daemon $DISTCC_ARGS &> #{CREW_PREFIX}/var/log/distccd.log &
    START_DISTCCDEOF
    FileUtils.install 'startdistccd', "#{CREW_DEST_PREFIX}/bin/startdistccd", mode: 0o755
    File.write 'stopdistccd', <<~STOP_DISTCCDEOF
      #!/bin/bash -a
      killall -9 distccd
    STOP_DISTCCDEOF
    FileUtils.install 'stopdistccd', "#{CREW_DEST_PREFIX}/bin/stopdistccd", mode: 0o755
    # start distccd from bash.d, which loads after all of env.d via #{CREW_PREFIX}/etc/profile
    File.write 'bash.d_distccd', <<~BASHDDISTCCD_EOF
      source #{CREW_PREFIX}/bin/startdistccd
    BASHDDISTCCD_EOF
    FileUtils.install 'bash.d_distccd', "#{CREW_DEST_PREFIX}/etc/bash.d/distccd", mode: 0o644
    File.write 'env.d_distccd', <<~ENVDDISTCCD_EOF
      [[ -n ${START_DISTCCD} ]] && PATH=#{CREW_LIB_PREFIX}/distcc/bin:$PATH
    ENVDDISTCCD_EOF
    FileUtils.install 'env.d_distccd', "#{CREW_DEST_PREFIX}/etc/env.d/distccd", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "Set the env variable START_DISTCCD with \"echo 'export START_DISTCCD=1' >> ~/.bashrc\" \nand run 'startdistccd' to enable distccd."
  end
end
