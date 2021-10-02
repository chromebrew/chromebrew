require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 programs to the built-in ChromeOS Exo Wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/'
  version '20210109-5'
  license 'BSD-Google'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/platform2.git'
  git_hashtag 'f3b2e2b6a8327baa2e62ef61036658c258ab4a09'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20210109-5_armv7l/sommelier-20210109-5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20210109-5_armv7l/sommelier-20210109-5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20210109-5_i686/sommelier-20210109-5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20210109-5_x86_64/sommelier-20210109-5-chromeos-x86_64.tar.xz',
  })
  binary_sha256({
    aarch64: '2b270ec19410594ba6969f20e168cc91739f090315a8046a95e303cac71d723e',
     armv7l: '2b270ec19410594ba6969f20e168cc91739f090315a8046a95e303cac71d723e',
       i686: '0b8f8ee99968f1cd3c429c9a1a7ffb6577b8ec430b91c83d1f7fa1c3856e7a3b',
     x86_64: 'b652d65be2330108b4232dbf79991cc27c755a4fed958480b62696f4499b036d',
  })

  depends_on 'libdrm'
  depends_on 'libxcb'
  depends_on 'libxcomposite' => :build
  depends_on 'libxfixes' => :build
  depends_on 'libxkbcommon'
  depends_on 'mesa'
  depends_on 'pixman'
  depends_on 'procps' # for pgrep in wrapper script
  depends_on 'psmisc'
  depends_on 'wayland'
  depends_on 'xauth'
  depends_on 'xdpyinfo' # for xdpyinfo in wrapper script
  depends_on 'xsetroot' # for xsetroot in sommelierrc script
  depends_on 'xhost' # for xhost in sommelierd script
  depends_on 'xwayland'
  depends_on 'xxd_standalone' # for xxd in wrapper script

  case ARCH
  when 'armv7l', 'aarch64'
    @peer_cmd_prefix = '/lib/ld-linux-armhf.so.3'
  when 'i686'
    @peer_cmd_prefix = '/lib/ld-linux-i686.so.2'
  when 'x86_64'
    @peer_cmd_prefix = '/lib64/ld-linux-x86-64.so.2'
  end

  def self.preflight
    @container_check = `grep :/docker /proc/self/cgroup | wc -l`
    unless File.socket?('/var/run/chrome/wayland-0') || !@container_check.to_i.zero?
      abort 'This package is not compatible with your device :/'.lightred
    end
  end

  def self.patch
    # Patch to avoid error with GCC > 9.x
    # ../sommelier.cc:3238:10: warning: ‘char* strncpy(char*, const char*, size_t)’ specified bound 108 equals destination size [-Wstringop-truncation]
    Kernel.system "sed -i 's/sizeof(addr.sun_path))/sizeof(addr.sun_path) - 1)/' sommelier.cc",
                  chdir: 'vm_tools/sommelier'
  end

  def self.build
    Dir.chdir('vm_tools/sommelier') do
      # lld is needed so libraries linked to system libraries (e.g. libgbm.so) can be linked against, since those are required for graphics acceleration.

      system <<~BUILD
        env CC=clang CXX=clang++ \
          meson #{CREW_MESON_OPTIONS} \
          -Db_asneeded=false \
          -Db_lto=true \
          -Db_lto_mode=thin \
          -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland \
          -Dxwayland_gl_driver_path=/usr/#{ARCH_LIB}/dri -Ddefault_library=both \
          -Dxwayland_shm_driver=noop -Dshm_driver=noop -Dvirtwl_device=/dev/null \
          -Dpeer_cmd_prefix="#{CREW_PREFIX}#{@peer_cmd_prefix}" \
          builddir
      BUILD

      system 'meson configure builddir'
      system 'samu -C builddir'

      Dir.chdir('builddir') do
        system 'curl -L "https://chromium.googlesource.com/chromiumos/containers/sommelier/+/fbdefff6230026ac333eac0924d71cf824e6ecd8/sommelierrc?format=TEXT" | base64 --decode > sommelierrc'

        @sommelierenv = <<~EOF
          set -a
          CLUTTER_BACKEND=wayland
          DISPLAY=:0
          GDK_BACKEND=x11
          SCALE=1
          SOMMELIER_ACCELERATORS='Super_L,<Alt>bracketleft,<Alt>bracketright'
          WAYLAND_DISPLAY=wayland-0
          XDG_RUNTIME_DIR=/var/run/chrome

          case "$(uname -m)" in
          x86_64|i686)
            sort_result="$(sort -V <<< "$(uname -r)"$'\\n'"4.16.0" | tail -n1)"
            if [[ "${sort_result}" == "4.16.0" ]]; then
              MESA_LOADER_DRIVER_OVERRIDE=i965
            fi
          ;;
          esac

          if [ -f "~/.sommelier.env" ]; then
            source ~/.sommelier.env
          fi

          set +a
        EOF

        # Create local startup and shutdown scripts

        # sommelier_sh
        # This file via:
        # crostini: /opt/google/cros-containers/bin/sommelier
        # https://source.chromium.org/chromium/chromium/src/+/master:third_party/chromite/third_party/lddtree.py;drc=46da9a8dfce28c96765dc7d061f0c6d7a52e7352;l=146
        IO.write 'sommelier_sh', <<~EOF
          #!/bin/bash
          function readlink(){
            coreutils --coreutils-prog=readlink "$@"
          }

          if base=$(readlink "$0" 2>/dev/null); then
            case $base in
            /*) base=$(readlink -f "$0" 2>/dev/null);; # if $0 is abspath symlink, make symlink fully resolved.
            *)  base=$(dirname "$0")/"${base}";;
            esac
          else
            case $0 in
            /*) base=$0;;
            *)  base=${PWD:-`pwd`}/$0;;
            esac
          fi
          basedir=${base%/*}
          LD_ARGV0_REL="../bin/sommelier" \
            exec "${basedir}/..#{@peer_cmd_prefix}" \
              --library-path \
              "${basedir}/../#{ARCH_LIB}" \
              --inhibit-rpath '' \
              "${base}.elf" \
              "$@"
        EOF

        # sommelierd
        IO.write 'sommelierd', <<~EOF
          #!/bin/bash -a

          source ${CREW_PREFIX}/etc/env.d/sommelier.env &>/dev/null
          set +a
          mkdir -p #{CREW_PREFIX}/var/{log,run}
          checksommelierwayland () {
            [[ -f "#{CREW_PREFIX}/var/run/sommelier-wayland.pid" ]] || return 1
            /sbin/ss --unix -a -p | grep "\b$(cat #{CREW_PREFIX}/var/run/sommelier-wayland.pid)" | grep wayland &>/dev/null
          }
          checksommelierxwayland () {
            xdpyinfo -display "${DISPLAY}" &>/dev/null
          }

          ## As per https://www.reddit.com/r/chromeos/comments/8r5pvh/crouton_sommelier_openjdk_and_oracle_sql/e0pfknx/
          ## One needs a second sommelier instance for wayland clients since at some point wl-drm was not implemented
          ## in ChromeOS's wayland compositor.
          #if ! checksommelierwayland ; then
          #  pkill -F #{CREW_PREFIX}/var/run/sommelier-wayland.pid &>/dev/null
          #  rm ${XDG_RUNTIME_DIR}/wayland-1*
          #  sommelier --parent \
          #    --peer-cmd-prefix="#{CREW_PREFIX}#{@peer_cmd_prefix}" \
          #    --drm-device=/dev/dri/renderD128 --shm-driver=noop \
          #    --data-driver=noop --display=wayland-0 --socket=wayland-1 \
          #    --virtwl-device=/dev/null &> #{CREW_PREFIX}/var/log/sommelier.log &
          #  echo "$!" > #{CREW_PREFIX}/var/run/sommelier-wayland.pid
          #fi

          if ! checksommelierxwayland; then
            pkill -F #{CREW_PREFIX}/var/run/sommelier-xwayland.pid &>/dev/null
            DISPLAY="${DISPLAY:0:3}"

            sommelier -X \
              --x-display=${DISPLAY}  \
              --scale=${SCALE} --glamor \
              --drm-device=/dev/dri/renderD128 \
              --virtwl-device=/dev/null \
              --shm-driver=noop --data-driver=noop \
              --display=wayland-0 \
              --xwayland-path=/usr/local/bin/Xwayland \
              --xwayland-gl-driver-path=#{CREW_LIB_PREFIX}/dri \
              --peer-cmd-prefix="#{CREW_PREFIX}#{@peer_cmd_prefix}" \
              --no-exit-with-child \
              /bin/sh -c "touch ~/.Xauthority
                xauth -f ~/.Xauthority add ${DISPLAY} . $(xxd -l 16 -p /dev/urandom)
                source #{CREW_PREFIX}/etc/sommelierrc" \
            &>> #{CREW_PREFIX}/var/log/sommelier.log

            echo "${!}" > #{CREW_PREFIX}/var/run/sommelier-xwayland.pid
            xhost +si:localuser:root &>/dev/null
          fi
        EOF

        # startsommelier
        IO.write 'startsommelier', <<~EOF
          #!/bin/bash -a

          source ~/.sommelier-default.env &>/dev/null
          source ~/.sommelier.env &>/dev/null
          set +a

          checksommelierwayland () {
            #if [ -f "#{CREW_PREFIX}/var/run/sommelier-wayland.pid" ]; then
            #  /sbin/ss --unix -a -p |\
            #    grep "\b$(cat #{CREW_PREFIX}/var/run/sommelier-wayland.pid)" |\
            #    grep wayland &>/dev/null
            #else
            #  return 1
            #fi
            return 0
          }
          checksommelierxwayland () {
            xdpyinfo -display "${DISPLAY}" &>/dev/null
          }
          if ! checksommelierwayland || ! checksommelierxwayland ; then
            [ -f  #{CREW_PREFIX}/bin/stopbroadway ] && stopbroadway
            #{CREW_PREFIX}/sbin/sommelierd &> /dev/null &
          fi
          wait=3
          until checksommelierwayland && checksommelierxwayland; do
            [ "${wait}" -le "0" ] && break
            (( wait = wait - 1 ))
            sleep 3
          done

          SOMMWPIDS="$(pgrep -f "sommelier.elf --parent" 2> /dev/null)"
          SOMMWPROCS="$(pgrep -fa "sommelier.elf --parent" 2> /dev/null)"
          SOMMXPIDS="$(pgrep -f "sommelier.elf -X" 2> /dev/null)"
          SOMMXPROCS="$(pgrep -fa "sommelier.elf -X" 2> /dev/null)"

          if checksommelierwayland && checksommelierxwayland ; then
            echo -e "sommelier processes running: ${SOMMWPIDS} ${SOMMXPIDS}"
          else
            echo "some sommelier processes failed to start"
            echo -e "sommelier processes running: ${SOMMWPROCS} \\n ${SOMMXPROCS}"
            exit 1
          fi
        EOF

        # stopsommelier
        IO.write 'stopsommelier', <<~EOF
          #!/bin/bash
          SOMM="$(pgrep -fc sommelier.elf 2> /dev/null)"
          if [[ "${SOMM}" -gt "0" ]]; then
            pkill -f sommelier.elf &>/dev/null
            pkill -F #{CREW_PREFIX}/var/run/sommelier-wayland.pid &>/dev/null
            pkill -F #{CREW_PREFIX}/var/run/sommelier-xwayland.pid &>/dev/null
          else
            exit 0
          fi
          if [[ "$(pgrep -fc sommelier.elf 2> /dev/null)" -gt "0" ]]; then
            echo "sommelier failed to stop"
            exit 1
          else
            echo "sommelier stopped"
          fi
        EOF

        # restartsommelier
        IO.write 'restartsommelier', <<~EOF
          #!/bin/bash
          stopsommelier && startsommelier
        EOF

        # start sommelier from bash.d, which loads after all of env.d via #{CREW_PREFIX}/etc/profile
        @bashd_sommelier = <<~EOF
          startsommelier
        EOF
      end
    end
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/sbin #{CREW_DEST_PREFIX}/etc/bash.d
                         #{CREW_DEST_PREFIX}/etc/env.d CREW_DEST_HOME]
    Dir.chdir('vm_tools/sommelier') do
      system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
      Dir.chdir('builddir') do
        FileUtils.mv "#{CREW_DEST_PREFIX}/bin/sommelier", "#{CREW_DEST_PREFIX}/bin/sommelier.elf"
        FileUtils.install 'sommelier_sh', "#{CREW_DEST_PREFIX}/bin/sommelier", mode: 0o755
        FileUtils.install 'sommelierd', "#{CREW_DEST_PREFIX}/sbin/sommelierd", mode: 0o755
        FileUtils.install 'startsommelier', "#{CREW_DEST_PREFIX}/bin/startsommelier", mode: 0o755
        FileUtils.ln_sf 'startsommelier', "#{CREW_DEST_PREFIX}/bin/initsommelier"
        FileUtils.install 'stopsommelier', "#{CREW_DEST_PREFIX}/bin/stopsommelier", mode: 0o755
        FileUtils.install 'restartsommelier', "#{CREW_DEST_PREFIX}/bin/restartsommelier", mode: 0o755
        FileUtils.install 'sommelierrc', "#{CREW_DEST_PREFIX}/etc/sommelierrc", mode: 0o644
      end
    end

    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/sommelier", @bashd_sommelier)
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/sommelier", @sommelierenv)
  end

  def self.postinstall
    # all tasks are done by sommelier.env now
    puts
    puts 'Removing old sommelier env variable loading code in ~/.bashrc'.lightblue
    system 'sed -i "/[sS]ommelier/d" -i.backup ~/.bashrc'
    puts 'To complete the installation, execute the following:'.orange
    puts 'source ~/.bashrc'.orange

    puts
    FileUtils.touch "#{HOME}/.sommelier.env" unless File.exist? "#{HOME}/.sommelier.env"
    puts <<~EOT.lightblue
      To adjust sommelier environment variables, edit #{CREW_PREFIX}/etc/env.d/sommelier
      Default values are in #{CREW_PREFIX}/etc/env.d/sommelier

      To start the sommelier daemon, run 'startsommelier'
      To stop the sommelier daemon, run 'stopsommelier'
      To restart the sommelier daemon, run 'restartsommelier'

    EOT
    puts <<~EOT.orange
      Please be aware that gui applications may not work without the
      sommelier daemon running.

      The sommelier daemon may also have to be restarted with
      'restartsommelier' after waking your device.

      (If you are upgrading from an earlier version of sommelier,
      also run 'restartsommelier'.)
    EOT
  end
end
