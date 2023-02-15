require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 programs to the built-in ChromeOS Exo Wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/'
  version '20230125-1'
  license 'BSD-Google'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/platform2.git'
  git_hashtag 'dbd90c6b002f7d0867cc0b0f1538cc979b688d13'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20230125-1_armv7l/sommelier-20230125-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20230125-1_armv7l/sommelier-20230125-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20230125-1_i686/sommelier-20230125-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20230125-1_x86_64/sommelier-20230125-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4a5719e1ab6cbf277a3360c2f3eb60483be474b07725d123d5cbf3426540603a',
     armv7l: '4a5719e1ab6cbf277a3360c2f3eb60483be474b07725d123d5cbf3426540603a',
       i686: '41df727007973520d856253a93ed85787a98d1948489502184eaba5b6d6474e9',
     x86_64: 'f275bc12bb18c5af2d97c6b391de77c7fa4e293f1fcb3922f03af7ae20e4e8c0'
  })

  depends_on 'diffutils' # L (for diff usage in postinstall)
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libdrm' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' => :build
  depends_on 'libxcvt'
  depends_on 'libxfixes' => :build
  depends_on 'libxkbcommon' # R
  depends_on 'llvm' # R
  depends_on 'mesa' # R
  depends_on 'pixman' # R
  depends_on 'procps' # for pgrep in wrapper script
  depends_on 'psmisc'
  depends_on 'wayland' # R
  depends_on 'xauth'
  depends_on 'xhost' # for xhost in sommelierd script
  depends_on 'xkbcomp' # The sommelier log complains if this isn't installed.
  depends_on 'xorg_xset' # for xset in wrapper script
  depends_on 'xsetroot' # for xsetroot in /usr/local/etc/sommelierrc script
  depends_on 'xwayland' # L
  depends_on 'xxd_standalone' # for xxd in wrapper script

  no_shrink

  def self.preflight
    return if File.socket?('/var/run/chrome/wayland-0') || CREW_IN_CONTAINER

    abort 'This package is not compatible with your device :/'.lightred
  end

  def self.patch
    # Patch to avoid error with GCC > 9.x
    # ../sommelier.cc:3238:10: warning: ‘char* strncpy(char*, const char*, size_t)’ specified bound 108 equals destination size [-Wstringop-truncation]
    Kernel.system "sed -i 's/sizeof(addr.sun_path))/sizeof(addr.sun_path) - 1)/' sommelier.cc",
                  chdir: 'vm_tools/sommelier'
  end

  def self.build
    case ARCH
    when 'armv7l', 'aarch64'
      @peer_cmd_prefix = '/lib/ld-linux-armhf.so.3'
    when 'i686'
      @peer_cmd_prefix = '/lib/ld-2.23.so'
    when 'x86_64'
      @peer_cmd_prefix = '/lib64/ld-linux-x86-64.so.2'
    end
    Dir.chdir('vm_tools/sommelier') do
      # lld is needed so libraries linked to system libraries (e.g. libgbm.so) can be linked against, since those are required for graphics acceleration.

      system <<~BUILD
        env CC=clang CXX=clang++ \
          meson setup #{CREW_MESON_OPTIONS.gsub('-fuse-ld=mold', '-fuse-ld=lld').gsub('-ffat-lto-objects', '')} \
          -Db_asneeded=false \
          -Db_lto=true \
          -Db_lto_mode=thin \
          -Dwith_tests=false \
          -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland \
          -Dxwayland_gl_driver_path=#{CREW_LIB_PREFIX}/dri \
          -Ddefault_library=both \
          builddir
      BUILD

      system 'meson configure builddir'
      system 'samu -C builddir'

      Dir.chdir('builddir') do
        system 'curl -L "https://chromium.googlesource.com/chromiumos/containers/sommelier/+/fbdefff6230026ac333eac0924d71cf824e6ecd8/sommelierrc?format=TEXT" | base64 --decode > sommelierrc'

        @sommelierenv = <<~SOMMELIERENVEOF
          set -a
          CLUTTER_BACKEND=wayland
          DISPLAY=:0
          GDK_BACKEND=x11
          SCALE=1
          SOMMELIER_ACCELERATORS='Super_L,<Alt>bracketleft,<Alt>bracketright'
          WAYLAND_DISPLAY=wayland-0
          XDG_RUNTIME_DIR=/var/run/chrome
          SOMMELIER_VM_IDENTIFIER=chromebrew

          if grep -q GenuineIntel /proc/cpuinfo ;then
            check_linux_version() {
                maj_ver=$1
                min_ver=$2
                version_good=$(uname -r | awk 'BEGIN{ FS="."};
                { if ($1 < '"${maj_ver}"') { print "N"; }
                  else if ($1 == '"${maj_ver}"') {
                      if ($2 < '"${min_ver}"') { print "N"; }
                      else { print "Y"; }
                  }
                  else { print "Y"; }
                }')

                if [ "$version_good" = "N" ]; then
                    return 1
                fi
            }
            case "$(uname -m)" in
            x86_64|i686)
              if ! check_linux_version 4 16; then
                MESA_LOADER_DRIVER_OVERRIDE=i965
              elif check_linux_version 5 10; then
                MESA_LOADER_DRIVER_OVERRIDE=iris
              fi
            ;;
            esac
          fi

          # Override environment settings above.
          [ -f "~/.sommelier.env" ] && source ~/.sommelier.env

          set +a
        SOMMELIERENVEOF

        # Create local startup and shutdown scripts

        # sommelier_sh
        # This file via:
        # crostini: /opt/google/cros-containers/bin/sommelier
        # https://source.chromium.org/chromium/chromium/src/+/master:third_party/chromite/third_party/lddtree.py;drc=46da9a8dfce28c96765dc7d061f0c6d7a52e7352;l=146
        File.write 'sommelier_sh', <<~SOMMELIERSHEOF
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
        SOMMELIERSHEOF

        # sommelierd
        File.write 'sommelierd', <<~SOMMELIERDEOF
          #!/bin/bash -a

          source ${CREW_PREFIX}/etc/env.d/sommelier
          set +a
          mkdir -p #{CREW_PREFIX}/var/{log,run}
          checksommelierwayland () {
            [[ -f "#{CREW_PREFIX}/var/run/sommelier-wayland.pid" ]] || return 1
            /sbin/ss --unix -a -p | grep "\b$(cat #{CREW_PREFIX}/var/run/sommelier-wayland.pid)" | grep wayland &>/dev/null
          }
          checksommelierxwayland () {
            DISPLAY="${DISPLAY}" timeout 1s xset q &>/dev/null
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

            sommelier_cmd="sommelier -X \
              --x-display=${DISPLAY} \
              --scale=${SCALE} \
              ${SOMMELIER_DIRECT_SCALE} \
              --glamor \
              --force-drm-device=${SOMMELIER_DRM_DEVICE} \
              --display=wayland-0 \
              --xwayland-path=/usr/local/bin/Xwayland \
              --xwayland-gl-driver-path=#{CREW_LIB_PREFIX}/dri \
              --peer-cmd-prefix=#{CREW_PREFIX}#{@peer_cmd_prefix} \
              --enable-xshape \
              --noop-driver \
              --no-exit-with-child \
              /bin/sh -c \\"touch ~/.Xauthority
                xauth -f ~/.Xauthority add ${DISPLAY} . $(xxd -l 16 -p /dev/urandom)
                source #{CREW_PREFIX}/etc/sommelierrc\\""
            echo $sommelier_cmd >> #{CREW_PREFIX}/var/log/sommelier.log
            $sommelier_cmd &>> #{CREW_PREFIX}/var/log/sommelier.log

            # echo "${!}" > #{CREW_PREFIX}/var/run/sommelier-xwayland.pid
            pgrep Xwayland > #{CREW_PREFIX}/var/run/sommelier-xwayland.pid
            xhost +si:localuser:root
          fi
        SOMMELIERDEOF

        # startsommelier
        File.write 'startsommelier', <<~STARTSOMMELIEREOF
          #!/bin/bash -a
          # Exit if in container.
          if [[ -f '/.dockerenv' ]]; then
            echo "Cannot run sommelier in a container."
            # Return or exit depending upon whether script was sourced.
            (return 0 2>/dev/null) && return 0 || exit 0
          fi
          set -a
          # Set DRM device here so output is visible, but don't run
          # some of these checks in an env.d file since we don't need
          # them run every time a shell is opened.
          # Get a list of all available DRM render nodes.
          DRM_DEVICES_LIST=($(cd /dev/dri/ || exit ; ls renderD*))

          # if two or more render nodes available, choose one based on the corresponding render device path:
          #   devices/platform/vegm/...: virtual GEM device provided by Chrome OS, hardware acceleration may not available on this node. (should be avoided)
          #   devices/pci*/...: linked to the actual graphics card device path, provided by graphics card driver. (preferred)
          #
          if [[ "${#DRM_DEVICES_LIST[@]}" -gt 1 ]]; then
            for dev in "${DRM_DEVICES_LIST[@]}"; do
              if [[ "$(coreutils --coreutils-prog=readlink -f "/sys/class/drm/${dev}/device/driver")" =~ (bus/pci|drm) ]]; then
                SOMMELIER_DRM_DEVICE="/dev/dri/${dev##*/}"
                echo -e "\e[1;33m""${#DRM_DEVICES_LIST[@]} DRM render nodes available, ${SOMMELIER_DRM_DEVICE} will be used.""\e[0m"
                break
              fi
            done
          else
            # if only one node available, use it directly
            SOMMELIER_DRM_DEVICE="/dev/dri/${DRM_DEVICES_LIST[0]##*/}"
          fi
          direct_scaling_possible() {
            # Check if milestone is greater than 105.
            milestone=$(grep CHROMEOS_RELEASE_CHROME_MILESTONE /etc/lsb-release | cut -d= -f2)
            (( $milestone > 105 )) && return 0
            return 1
          }
          # Not sure which milestone enables direct scale, so be
          # conservative.
          SOMMELIER_DIRECT_SCALE=
          if direct_scaling_possible; then
            echo -e "\e[1;33m""Sommelier can use direct scaling.""\e[0m"
            SOMMELIER_DIRECT_SCALE='--direct-scale'
          fi

          set +a

          checksommelierwayland () {
            #if [ -f "#{CREW_PREFIX}/var/run/sommelier-wayland.pid" ]; then
            #  /sbin/ss --unix -a -p |\
            #    grep "\b$(cat #{CREW_PREFIX}/var/run/sommelier-wayland.pid)" |\
            #    grep wayland &>/dev/null
            #else
            #  return 1
            #fi
            # Return or exit depending upon whether script was sourced.
            (return 0 2>/dev/null) && return 0 || exit 0
          }
          checksommelierxwayland () {
            DISPLAY="${DISPLAY}" timeout 1s xset q &>/dev/null
          }
          if ! checksommelierwayland || ! checksommelierxwayland ; then
            [ -f  #{CREW_PREFIX}/bin/stopbroadway ] && stopbroadway
            #{CREW_PREFIX}/sbin/sommelierd &>/dev/null &
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
            [[ -n ${SOMMWPROCS} || -n ${SOMMXPROCS} ]] && echo -e "sommelier processes running: ${SOMMWPROCS} \\n ${SOMMXPROCS}"
            # Return or exit depending upon whether script was sourced.
            (return 0 2>/dev/null) && return 1 || exit 1
          fi
        STARTSOMMELIEREOF

        # stopsommelier
        File.write 'stopsommelier', <<~STOPSOMMELIEREOF
          #!/bin/bash
          SOMM="$(pgrep -fc sommelier.elf 2> /dev/null)"
          if [[ "${SOMM}" -gt "0" ]]; then
            pkill -f sommelier.elf &>/dev/null
            pkill -F #{CREW_PREFIX}/var/run/sommelier-wayland.pid &>/dev/null
            pkill -F #{CREW_PREFIX}/var/run/sommelier-xwayland.pid &>/dev/null
          else
            # Return or exit depending upon whether script was sourced.
            (return 0 2>/dev/null) && return 0 || exit 0
          fi
          if [[ "$(pgrep -fc sommelier.elf 2> /dev/null)" -gt "0" ]]; then
            echo "sommelier failed to stop"
            # Return or exit depending upon whether script was sourced.
            (return 0 2>/dev/null) && return 1 || exit 1
          else
            echo "sommelier stopped"
          fi
        STOPSOMMELIEREOF

        # restartsommelier
        File.write 'restartsommelier', <<~RESTARTSOMMELIEREOF
          #!/bin/bash
          stopsommelier && startsommelier
        RESTARTSOMMELIEREOF

        # start sommelier from bash.d, which loads after all of env.d via #{CREW_PREFIX}/etc/profile
        @bashd_sommelier = <<~BASHDEOF
          source #{CREW_PREFIX}/bin/startsommelier
        BASHDEOF
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

    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/sommelier", @bashd_sommelier)
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/sommelier", @sommelierenv)
  end

  def self.postinstall
    # all tasks are done by sommelier.env now
    now = Time.now.strftime('%Y%m%d%H%M')
    FileUtils.cp "#{HOME}/.bashrc", "#{HOME}/.bashrc.#{now}"
    system "sed -i '/[sS]ommelier/d' #{HOME}/.bashrc"
    diff = `diff #{HOME}/.bashrc #{HOME}/.bashrc.#{now}`.chomp
    if diff == ''
      FileUtils.rm "#{HOME}/.bashrc.#{now}"
    else
      puts <<~EOT0.lightblue

        Removed old sommelier environment variables in ~/.bashrc.
        A backup of the original is stored in ~/.bashrc.#{now}.
        To complete the installation, execute the following:
        source ~/.bashrc
      EOT0
    end

    FileUtils.touch "#{HOME}/.sommelier.env" unless File.exist? "#{HOME}/.sommelier.env"
    puts <<~EOT1.lightblue

      The default environment is stored in #{CREW_PREFIX}/etc/env.d/sommelier.
    EOT1

    puts <<~EOT2.orange
      DO NOT EDIT THIS FILE SINCE UPDATES WILL OVERWRITE YOUR CHANGES.
    EOT2
    puts <<~EOT1.lightblue
      To override environment variables set above, edit ~/.sommelier.env instead.
      Information about those environment variables may be found on the
      Chromebrew wiki: https://github.com/chromebrew/chromebrew/wiki

      To start the sommelier daemon, run 'startsommelier'
      To stop the sommelier daemon, run 'stopsommelier'
      To restart the sommelier daemon, run 'restartsommelier'
    EOT1
    puts <<~EOT2.orange
      Please be aware that gui applications may not work without the
      sommelier daemon running.

      The sommelier daemon may also have to be restarted with
      'restartsommelier' after waking your device.

      (If you are upgrading from an earlier version of sommelier,
      also run 'restartsommelier'.)

      Please open a github issue at
      https://github.com/chromebrew/chromebrew/issues/new/choose
      with the output of both
       readlink -f "/sys/class/drm/renderD129/device/driver"
      and
       readlink -f "/sys/class/drm/renderD128/device/driver"
      if sommelier does not start properly on your arm ChromeOS device.
    EOT2
  end
end
