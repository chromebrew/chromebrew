require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 programs to the built-in ChromeOS Exo Wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/'
  @_ver = '20220207'
  version @_ver
  license 'BSD-Google'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-package-sommelier.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20220207_armv7l/sommelier-20220207-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20220207_armv7l/sommelier-20220207-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20220207_i686/sommelier-20220207-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20220207_x86_64/sommelier-20220207-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '74aa4a3bb9f2839426124d31fe947859903a9f076ac58fda6576aedb3a8295c4',
     armv7l: '74aa4a3bb9f2839426124d31fe947859903a9f076ac58fda6576aedb3a8295c4',
       i686: '158a719de95d18cb98ec842da1201c75803e5e16dbdc6e51ca467e1a104349f1',
     x86_64: '94feec18f9c496f2ac0d6c6b77584d70492105425815224cafe59e9086b101fe'
  })

  depends_on 'libdrm'
  depends_on 'libxcb'
  depends_on 'libxcomposite' => :build
  depends_on 'libxfixes' => :build
  depends_on 'libxkbcommon'
  depends_on 'llvm'
  depends_on 'mesa'
  depends_on 'pixman'
  depends_on 'psmisc'
  depends_on 'wayland'
  depends_on 'xauth'
  depends_on 'xdpyinfo' # for xdpyinfo in sommelierrc script
  depends_on 'xsetroot' # for xsetroot in sommelierrc script
  depends_on 'xhost' # for xhost in sommelierrc script
  depends_on 'xrdb' # for xrdb in sommelierrc script
  depends_on 'xwayland'

  case ARCH
  when 'armv7l', 'aarch64'
    @peer_cmd_prefix = '/lib/ld-linux-armhf.so.3'
  when 'i686'
    @peer_cmd_prefix = '/lib/ld-linux.so.2'
  when 'x86_64'
    @peer_cmd_prefix = '/lib64/ld-linux-x86-64.so.2'
  end

  def self.preflight
    case ARCH
    when 'armv7l', 'aarch64'
      @container_check = File.exist?('/.dockerenv')
    when 'i686', 'x86_64'
      @container_check = `/usr/bin/crossystem inside_vm` == '1'
    end
    unless File.socket?('/var/run/chrome/wayland-0') || @container_check
      abort 'This package is not compatible with your device :/'.lightred
    end
  end

  def self.patch
    system 'cat patches/*.patch | (cd sommelier_src; patch -p1)'
  end

  def self.build
    Dir.chdir('sommelier_src') do
      system CREW_ENV_OPTIONS_HASH.merge({ 'CC' => 'clang', 'CXX' => 'clang++' }), <<~BUILD
        meson #{CREW_MESON_OPTIONS} \
          -Db_asneeded=false \
          -Db_lto=true \
          -Db_lto_mode=thin \
          -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland \
          -Dxwayland_gl_driver_path=#{CREW_PREFIX}/#{ARCH_LIB}/dri \
          -Ddefault_library=both \
          -Dwith_tests=false \
          builddir
      BUILD

      system 'meson configure builddir'
      system 'samu -C builddir'
    end
  end

  def self.install
    FileUtils.mkdir_p %W[
      #{CREW_DEST_PREFIX}/bin
      #{CREW_DEST_PREFIX}/sbin
      #{CREW_DEST_PREFIX}/etc/env.d
      #{CREW_DEST_PREFIX}/etc/bash.d
    ]

    system "DESTDIR=#{CREW_DEST_DIR} samu -C sommelier_src/builddir install"

    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/sommelier", "#{CREW_DEST_PREFIX}/bin/sommelier.elf"

    FileUtils.install 'sommelier-wrapper', "#{CREW_DEST_PREFIX}/bin/sommelier", mode: 0o755
    FileUtils.install 'sommelierd', "#{CREW_DEST_PREFIX}/bin/sommelierd", mode: 0o755
    FileUtils.install 'sommelierrc', "#{CREW_DEST_PREFIX}/etc/sommelierrc", mode: 0o644
    FileUtils.install 'sommelier.env', "#{CREW_DEST_PREFIX}/etc/env.d/sommelier", mode: 0o644

    FileUtils.ln_s 'sommelierd', "#{CREW_DEST_PREFIX}/bin/startsommelier"
    FileUtils.ln_s 'sommelierd', "#{CREW_DEST_PREFIX}/bin/restartsommelier"
    FileUtils.ln_s 'sommelierd', "#{CREW_DEST_PREFIX}/bin/stopsommelier"

    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/sommelier", 'startsommelier', perm: 0o644
  end

  def self.postinstall
    puts '', <<~RESTARTSOMMELIER_EOT.orange
      To complete the installation, execute the following:
      source #{CREW_PREFIX}/etc/profile
      restartsommelier
    RESTARTSOMMELIER_EOT

    puts <<~ENV_ADJUSTMENT_EOT.lightblue
      To adjust sommelier environment variables, edit #{CREW_PREFIX}/etc/env.d/sommelier
      Default values are in #{CREW_PREFIX}/etc/env.d/sommelier

      Run `startsommelier` to start sommelier daemon.
      Run `stopsommelier` to stop all sommelier daemon.
      Run `restartsommelier` to restart sommelier daemon
    ENV_ADJUSTMENT_EOT

    puts <<~GUI_WARNING_EOT.orange
      Please be aware that GUI applications may not work without the sommelier daemon running.
    GUI_WARNING_EOT
  end
end
