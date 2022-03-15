require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 programs to the built-in ChromeOS Exo Wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/'
  version '20211129'
  license 'BSD-Google'
  compatibility 'all'
  source_url 'https://github.com/supechicken/crew-sommelier.git'
  git_branch 'main'

  depends_on 'libdrm'
  depends_on 'libxcb'
  depends_on 'libxcomposite' => :build
  depends_on 'libxfixes' => :build
  depends_on 'libxkbcommon'
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
    FileUtils.mkdir_p %W[ #{CREW_DEST_PREFIX}/bin
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
    puts '', <<~EOT.orange
      To complete the installation, execute the following:
      source #{CREW_PREFIX}/etc/profile
      restartsommelier
    EOT

    puts <<~EOT.lightblue
      To adjust sommelier environment variables, edit #{CREW_PREFIX}/etc/env.d/sommelier
      Default values are in #{CREW_PREFIX}/etc/env.d/sommelier

      Run `startsommelier` to start sommelier daemon.
      Run `stopsommelier` to stop all sommelier daemon.
      Run `restartsommelier` to restart sommelier daemon
    EOT

    puts <<~EOT.orange
      Please be aware that GUI applications may not work without the sommelier daemon running.
    EOT
  end
end
