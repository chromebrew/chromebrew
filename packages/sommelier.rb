require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 programs to the built-in ChromeOS Exo Wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/'
  version '20221117-3'
  license 'BSD-Google'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/platform2.git'
  git_hashtag 'b63df163ab11f07b63d0e7a866f044aa07c7e0b2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20221117-3_armv7l/sommelier-20221117-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20221117-3_armv7l/sommelier-20221117-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20221117-3_i686/sommelier-20221117-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sommelier/20221117-3_x86_64/sommelier-20221117-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bb810cb6c79ea4d3767a2f1e7f55f49318aec27b661646aabb3d6b805999a13b',
     armv7l: 'bb810cb6c79ea4d3767a2f1e7f55f49318aec27b661646aabb3d6b805999a13b',
       i686: '3b132883f20f85eca779a8ba91d51af5f28224ade48d3e4abfb30da8014552ff',
     x86_64: '271109dc9bd10e8feded352b5bdaaf2e109082c478f7a766f24ca3ee9fb33279'
  })

  depends_on 'libdrm'
  depends_on 'libxcb'
  depends_on 'libxcomposite' => :build
  depends_on 'libxcvt'
  depends_on 'libxfixes' => :build
  depends_on 'libxkbcommon'
  depends_on 'llvm' # R
  depends_on 'mesa'
  depends_on 'pixman'
  depends_on 'procps' # for pgrep in wrapper script
  depends_on 'psmisc'
  depends_on 'wayland'
  depends_on 'xauth'
  depends_on 'xkbcomp' # The sommelier log complains if this isn't installed.
  depends_on 'xorg_xset' # for xset in wrapper script
  depends_on 'xhost' # for xhost in sommelierd script
  depends_on 'xsetroot' # for xsetroot in /usr/local/etc/sommelierrc script
  depends_on 'xwayland'
  depends_on 'xxd_standalone' # for xxd in wrapper script
  depends_on 'gcc' # R
  depends_on 'glibc' # R

  def self.preflight
    return if File.socket?('/var/run/chrome/wayland-0') || CREW_IN_CONTAINER

    abort 'This package is not compatible with your device :/'.lightred
  end

  def self.patch
    # Patch to avoid error with GCC > 9.x
    # ../sommelier.cc:3238:10: warning: ‘char* strncpy(char*, const char*, size_t)’ specified bound 108 equals destination size [-Wstringop-truncation]
    Kernel.system "sed -i 's/sizeof(addr.sun_path))/sizeof(addr.sun_path) - 1)/' sommelier.cc",
                  chdir: 'vm_tools/sommelier'
    return unless ARCH == 'armv7l' || ARCH == 'aarch64'

    # See https://github.com/chromebrew/chromebrew/pull/7653#issuecomment-1320804418
    File.write 'vm_tools/sommelier/arm.patch', <<~'ARM_PATCH_EOF'
      diff -Nur a/sommelier.cc b/sommelier.cc
      --- a/sommelier.cc	2022-11-06 19:29:16.580361574 +0800
      +++ b/sommelier.cc	2022-11-06 19:37:28.830367176 +0800
      @@ -616,7 +616,7 @@
             data_device_manager->host_global =
                 sl_data_device_manager_global_create(ctx);
           }
      -  } else if (strcmp(interface, "xdg_wm_base") == 0) {
      +  } else if ((strcmp(interface, "xdg_wm_base") == 0) || (strcmp(interface, "zxdg_shell_v6") == 0)) {
           struct sl_xdg_shell* xdg_shell =
               static_cast<sl_xdg_shell*>(malloc(sizeof(struct sl_xdg_shell)));
           assert(xdg_shell);
    ARM_PATCH_EOF
    Kernel.system 'patch -Np1 -i arm.patch', chdir: 'vm_tools/sommelier'
  end

  def self.build
    case ARCH
    when 'armv7l', 'aarch64'
      @peer_cmd_prefix = '/lib/ld-linux-armhf.so.3'
    when 'i686'
      @peer_cmd_prefix = '/lib/ld-linux-i686.so.2'
    when 'x86_64'
      @peer_cmd_prefix = '/lib64/ld-linux-x86-64.so.2'
    end
    Dir.chdir('vm_tools/sommelier') do
      # lld is needed so libraries linked to system libraries (e.g. libgbm.so) can be linked against, since those are required for graphics acceleration.

      system <<~BUILD
        env CC=clang CXX=clang++ \
          meson #{CREW_MESON_OPTIONS} \
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

          if [ -f "~/.sommelier.env" ]; then
            source ~/.sommelier.env
          fi

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

          source ${CREW_PREFIX}/etc/env.d/sommelier.env &>/dev/null
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

            sommelier -X \
              --x-display=${DISPLAY} \
              --scale=${SCALE} \
              ${SOMMELIER_DIRECT_SCALE} \
              --glamor \
              --force-drm-device=${SOMMELIER_DRM_DEVICE} \
              --display=wayland-0 \
              --xwayland-path=/usr/local/bin/Xwayland \
              --xwayland-gl-driver-path=#{CREW_LIB_PREFIX}/dri \
              --peer-cmd-prefix="#{CREW_PREFIX}#{@peer_cmd_prefix}" \
              --enable-xshape \
              --noop-driver \
              --no-exit-with-child \
              /bin/sh -c "touch ~/.Xauthority
                xauth -f ~/.Xauthority add ${DISPLAY} . $(xxd -l 16 -p /dev/urandom)
                source #{CREW_PREFIX}/etc/sommelierrc" \
            &>> #{CREW_PREFIX}/var/log/sommelier.log

            echo "${!}" > #{CREW_PREFIX}/var/run/sommelier-xwayland.pid
            xhost +si:localuser:root &>/dev/null
          fi
        SOMMELIERDEOF

        # startsommelier
        File.write 'startsommelier', <<~STARTSOMMELIEREOF
          #!/bin/bash -a
          set -a
          # Set DRM device here so output is visible, but don't run
          # some of these checks in an env.d file since we don't need
          # them run every time a shell is opened.
          # Get a list of all available DRM render nodes.
          DRM_DEVICES_LIST=( /sys/class/drm/renderD* )

          # if two or more render nodes available, choose one based on the corresponding render device path:
          #   devices/platform/vegm/...: virtual GEM device provided by Chrome OS, hardware acceleration may not available on this node. (should be avoided)
          #   devices/pci*/...: linked to the actual graphics card device path, provided by graphics card driver. (preferred)
          #
          if [[ "${#DRM_DEVICES_LIST[@]}" > 1 ]]; then
            for dev in ${DRM_DEVICES_LIST[@]}; do
              if [[ "$(coreutils --coreutils-prog=readlink -f "${dev}")" =~ devices/pci ]]; then
                SOMMELIER_DRM_DEVICE="/dev/dri/${dev##*/}"
                echo -e "\e[1;33m""${#DRM_DEVICES_LIST[@]} DRM render nodes available, ${SOMMELIER_DRM_DEVICE} will be used.""\e[0m"
                break
              fi
            done
          else
            # if only one node available, use it directly
            SOMMELIER_DRM_DEVICE="/dev/dri/${DRM_DEVICES_LIST[0]##*/}"
          fi
          check_chromeos_milestone() {
            # Check is passed milestone is greater than the current
            # ChromeOS milestone.
            milestone=$1
            version_good=$(grep CHROMEOS_RELEASE_CHROME_MILESTONE /etc/lsb-release | awk 'BEGIN{ FS="="};
            { if ($2 < '"${milestone}"') { print "N"; }
              else { print "Y"; }
            }')

            if [ "$version_good" = "N" ]; then
                return 1
            fi
          }
          # Not sure which milestone enables direct scale, so be
          # conservative.
          if ! check_chromeos_milestone 106; then
            SOMMELIER_DIRECT_SCALE=
          else
            echo -e "\e[1;33m""Sommelier can use direct scaling.""\e[0m"
            SOMMELIER_DIRECT_SCALE='--direct-scale'
          fi

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
    puts
    puts 'Removing old sommelier env variable loading code in ~/.bashrc'.lightblue
    system 'sed -i "/[sS]ommelier/d" -i.backup ~/.bashrc'
    puts 'To complete the installation, execute the following:'.orange
    puts 'source ~/.bashrc'.orange

    puts
    FileUtils.touch "#{HOME}/.sommelier.env" unless File.exist? "#{HOME}/.sommelier.env"
    puts <<~EOT1.lightblue
      To adjust sommelier environment variables, edit #{CREW_PREFIX}/etc/env.d/sommelier
      Default values are in #{CREW_PREFIX}/etc/env.d/sommelier

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
    EOT2
  end
end
