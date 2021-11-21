require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 programs to the built-in ChromeOS Exo Wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/'
  version '20211110'
  license 'BSD-Google'
  compatibility 'aarch64, armv7l, x86_64'
  source_url 'https://chromium.googlesource.com/chromiumos/platform2.git'
  git_hashtag '1f1be4598c9de7e3865666176a33cf2223c17944'

  binary_url({
  })
  binary_sha256({
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
  depends_on 'xdpyinfo' # for xdpyinfo in wrapper script
  depends_on 'xsetroot' # for xsetroot in sommelierrc script
  depends_on 'xhost' # for xhost in sommelierrc script
  depends_on 'xrdb' # for xrdb in sommelierrc script
  depends_on 'xwayland'

  case ARCH
  when 'armv7l', 'aarch64'
    @peer_cmd_prefix = '/lib/ld-linux-armhf.so.3'
  when 'x86_64'
    @peer_cmd_prefix = '/lib64/ld-linux-x86-64.so.2'
  end

  def self.preflight
    @container_check = system 'grep :/docker /proc/self/cgroup &> /dev/null'
    if @container_check and ENV['SKIP_SOMM_CHECK'].to_s != '1' and !File.socket?('/var/run/chrome/wayland-0')
      abort 'This package is not compatible with your device :/'.lightred
    end
  end

  def self.patch
    Dir.chdir('vm_tools/sommelier') do
      @_drm_device = Dir['/dev/dri/renderD*'][0]

      system <<~SED
        # open the drm device without calling the new open_virtgpu logic (since it only accept virgl gpu)
        sed -i -e 's#char\\* drm_device = NULL#char const \\*drm_device = "#{@_drm_device}"#' \
               -e 's#int drm_fd = open_virtgpu(&drm_device)#int drm_fd = open(drm_device, O_RDWR | O_CLOEXEC)#' sommelier.cc

        # point virtwl path to /dev/null (virtwl path is hardcoded now)
        sed -i -e 's:#define VIRTWL_DEVICE "/dev/wl0":#define VIRTWL_DEVICE "/dev/null":' virtualization/virtwl_channel.cc
      SED
      
      # replace the virtwl shm driver to noop shm driver (removed in commit 180e42d)
      @sommelier_shm_patch = { /^[[:blank:]]+struct sl_host_buffer\*.+?host_buffer->resource;$/m => <<~P1.chomp, /^[[:blank:]]+host_shm_pool->fd = fd;$/ => <<~P2.chomp }
        assert(host->proxy);
        sl_create_host_buffer(host->shm->ctx, client, id,
            wl_shm_pool_create_buffer(host->proxy, offset, width, height, stride, format), width, height);
      P1
        host_shm_pool->proxy = wl_shm_create_pool(host->shm_proxy, fd, size);
        wl_shm_pool_set_user_data(host_shm_pool->proxy, host_shm_pool);
        close(fd);
      P2

      @sommelier_shm = File.read('sommelier-shm.cc')
      @sommelier_shm_patch.each_pair do |k, v|
        @sommelier_shm.sub!(k, v)
      end

      File.write('sommelier-shm.cc', @sommelier_shm)
    end
  end

  def self.build
    Dir.chdir('vm_tools/sommelier') do
      # lld is needed so libraries linked to system libraries (e.g. libgbm.so) can be linked against, since those are required for graphics acceleration.
      system <<~BUILD
        #{CREW_ENV_OPTIONS.gsub('gold', 'lld')} CC=clang CXX=clang++ \
          meson #{CREW_MESON_OPTIONS} \
          -Db_asneeded=false \
          -Db_lto=true \
          -Db_lto_mode=thin \
          -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland \
          -Dxwayland_gl_driver_path=/usr/#{ARCH_LIB}/dri \
          -Ddefault_library=both \
          -Dwith_tests=false \
          builddir
      BUILD

      system 'meson configure builddir'
      system 'samu -C builddir'

      Dir.chdir('builddir') do
        @help = <<~EOF
          To start the sommelier daemon, run 'startsommelier'
          To stop the sommelier daemon, run 'stopsommelier'
          To restart the sommelier daemon, run 'restartsommelier'
        EOF

        @sommelierenv = <<~EOF
          set -a

          DISPLAY=:0
          SOMMELIER_ACCELERATORS='Super_L,<Alt>bracketleft,<Alt>bracketright'
          WAYLAND_DISPLAY=wayland-1

          : "${CLUTTER_BACKEND:=x11}"
          : "${GDK_BACKEND:=x11}"
          : "${SOMMELIER_LOG:=#{CREW_PREFIX}/var/log/sommelier.log}"
          : "${SOMMELIER_SCALE:=1.0}"
          : "${XCURSOR_SIZE:=30}"
          : "${XDG_RUNTIME_DIR:=/var/run/chrome}"

          case "$(uname -m)" in
          x86_64|i686)
            if [[ "$(sort -V <<< "$(uname -r)"$'\\n'"4.16.0" | tail -n1)" == "4.16.0" ]]; then
              MESA_LOADER_DRIVER_OVERRIDE=i965
            fi
          ;;
          esac

          [ -f "~/.sommelier.env" ] && source ~/.sommelier.env
        EOF

        # sommelierrc
        # This file via:
        # crostini: /etc/sommelierrc
        # https://chromium.googlesource.com/chromiumos/containers/cros-container-guest-tools/+/4329a11adc890173f2385848e7b1bcc89fbd150d/cros-sommelier/sommelierrc
        @sommelierrc = <<~EOF
          #!/usr/bin/env bash
          # Copyright 2019 The Chromium OS Authors. All rights reserved.
          # Use of this source code is governed by a BSD-style license that can be
          # found in the LICENSE file.
          # Startup hook for the sommelier service.  You should not need to modify this
          # file as customizations may be placed in ~/.sommelierrc instead.
          #
          # For documentation, see:
          # https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/

          set -e

          if { command -v xdpyinfo && command -v xrdb; } > /dev/null; then
            # Set Xft.dpi. Some applications (e.g. Chrome) use this to detect HiDPI.
            # 1.25x of the DPI reported by xdpyinfo = the DPI reported by xdpyinfo in Crostini
            DPI="$(( $(xdpyinfo | sed -n -E "/dots per inch/{s|^.* ([0-9]+)x.*$|\\1|g; p}") / 4 * 5 ))"
            xrdb -merge <<< "Xft.dpi: ${DPI}"

            # Set cursor theme
            if [[ ! "$(xrdb -get Xcursor.theme)" ]]; then
              xrdb -merge <<< 'Xcursor.theme: Adwaita'
            fi
          fi

          if command -v xsetroot > /dev/null; then
            xsetroot -cursor_name left_ptr
          fi

          if command -v xhost > /dev/null; then
            xhost +si:localuser:root
          fi

          if [ -f ~/.sommelierrc ]; then
            source ~/.sommelierrc
          fi
        EOF

        # Create local startup and shutdown scripts

        # sommelier_sh
        # This file via:
        # crostini: /opt/google/cros-containers/bin/sommelier
        # https://source.chromium.org/chromium/chromium/src/+/master:third_party/chromite/third_party/lddtree.py;drc=46da9a8dfce28c96765dc7d061f0c6d7a52e7352;l=146
        @sommelier_sh = <<~EOF
          #!/usr/bin/env bash

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
            *)  base=${PWD:-$(pwd)}/$0;;
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
        @sommelierd = <<~EOF
          #!/usr/bin/env bash

          function log () {
            echo -e "[log]: ${@}" >> ${SOMMELIER_LOG}
          }

          function err () {
            echo -e "[err]: ${@}"
          }

          function checksommelierwayland () {
            if [[ "$(/sbin/ss -lxp)" =~ ${WAYLAND_DISPLAY} ]]; then
              log "vaild wayland display (${WAYLAND_DISPLAY})"
            else
              err "sommelier-wayland failed to start"
              return 1
            fi
          }

          function checksommelierxwayland () {
            if [[ "$(/sbin/ss -lxp)" =~ ${DISPLAY/:/X} ]]; then
              log "sommelier running on display ${DISPLAY}"
            else
              err "sommelier-x11 failed to start"
              return 1
            fi
          }

          function start () {
            if ! checksommelierwayland &> /dev/null; then
              # start a nested (hardware accelerated) wayland compositor on top of exo
              nohup sommelier --parent \
                --peer-cmd-prefix='#{CREW_PREFIX}#{@peer_cmd_prefix}' \
                --display=wayland-0 \
                --socket=wayland-1 \
              &> ${SOMMELIER_LOG} &
              echo -n "${!}" > #{CREW_PREFIX}/var/run/sommelier-wayland.pid
            fi

            if ! checksommelierxwayland &> /dev/null; then
              nohup sommelier -X \
                --x-display=${DISPLAY}  \
                --glamor \
                --display=wayland-0 \
                --xwayland-path=#{CREW_PREFIX}/bin/Xwayland \
                --xwayland-gl-driver-path=#{CREW_LIB_PREFIX}/dri \
                --peer-cmd-prefix='#{CREW_PREFIX}#{@peer_cmd_prefix}' \
                --no-exit-with-child \
                  /usr/bin/env bash -c "touch ~/.Xauthority
                  xauth -f ~/.Xauthority add '${DISPLAY}' . '$(openssl rand -hex 16)'
                  source #{CREW_PREFIX}/etc/sommelierrc" \
              &>> ${SOMMELIER_LOG} &
              echo -n "${!}" > #{CREW_PREFIX}/var/run/sommelier-xwayland.pid
            fi
          }
          
          function stop () {
            {
              pkill -f sommelier.elf
              pkill -F #{CREW_PREFIX}/var/run/sommelier-wayland.pid &>/dev/null
              pkill -F #{CREW_PREFIX}/var/run/sommelier-xwayland.pid &>/dev/null
            } &> /dev/null

            # remove wayland socket after sommelier gone
            if [[ ! "$(/sbin/ss -lxp)" =~ ${WAYLAND_DISPLAY} ]]; then
              rm -f ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}*
            fi

            if [[ "$(ps -Ao args)" =~ sommelier.elf ]]; then
              echo "#{'sommelier failed to stop'.yellow}"
              exit 1
            else
              echo "sommelier stopped"
            fi
          }

          if [[ "${0}" == */startsommelier || "${1}" == '--start' ]]; then
            # reload env variables when started via startsommelier symlink
            [[ "${0}" == */startsommelier ]] && source #{CREW_PREFIX}/etc/env.d/sommelier

            if [ -z "${SOMMELIER_LOG}" ]; then
              err "SOMMELIER_LOG not set, exiting..."
              exit 1
            fi

            # clear log file
            echo -n > ${SOMMELIER_LOG}

            start

            # wait for sommelier start
            RETRY=20
            i=0
            until { checksommelierwayland && checksommelierxwayland; } &> /dev/null; do
              (( ${i} > ${RETRY} )) && break
              sleep 0.3
              ((i++))
            done

            if ! { checksommelierwayland && checksommelierxwayland; }; then
              echo -e "#{'some sommelier processes failed to start'.yellow}"
              echo "check ${SOMMELIER_LOG} for more info"
              exit 1
            fi

            echo -e "sommelier processes running: $(< #{CREW_PREFIX}/var/run/sommelier-wayland.pid) $(< #{CREW_PREFIX}/var/run/sommelier-xwayland.pid)"
          elif [[ "${0}" == */stopsommelier || "${1}" == '--stop' ]]; then
            stop
          elif [[ "${0}" == */restartsommelier || "${1}" == '--restart' ]]; then
            stop && exec startsommelier
          else
            echo -en "#{@help}"
            exit 1
          fi
        EOF

        # start sommelier from bash.d, which loads after all of env.d via #{CREW_PREFIX}/etc/profile
        @bashd_sommelier = 'sommelierd --start'
      end
    end
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/sbin #{CREW_DEST_PREFIX}/etc/bash.d
                         #{CREW_DEST_PREFIX}/etc/env.d CREW_DEST_HOME]
    Dir.chdir('vm_tools/sommelier') do
      system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
      FileUtils.mv "#{CREW_DEST_PREFIX}/bin/sommelier", "#{CREW_DEST_PREFIX}/bin/sommelier.elf"

      {
        "#{CREW_DEST_PREFIX}/bin/sommelier" => @sommelier_sh,
        "#{CREW_DEST_PREFIX}/bin/sommelierd" => @sommelierd,
        "#{CREW_DEST_PREFIX}/etc/sommelierrc" => @sommelierrc
      } .each_pair do |filename, v|
        File.write filename, v
        File.chmod 0755, filename
      end

      {
        "#{CREW_DEST_PREFIX}/bin/startsommelier" => 'sommelierd',
        "#{CREW_DEST_PREFIX}/bin/stopsommelier" => 'sommelierd',
        "#{CREW_DEST_PREFIX}/bin/restartsommelier" => 'sommelierd'
      } .each_pair do |link, target|
        FileUtils.ln_s target, link
      end
    end

    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/sommelier", @bashd_sommelier)
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/sommelier", @sommelierenv)
  end

  def self.postinstall
    # all tasks are done by sommelier.env now
    puts
    puts 'To complete the installation, execute the following:'.orange
    puts 'source ~/.bashrc'.orange
    puts

    FileUtils.touch "#{HOME}/.sommelier.env"
    puts <<~EOT.lightblue
      To adjust sommelier environment variables, edit #{CREW_PREFIX}/etc/env.d/sommelier
      Default values are in #{CREW_PREFIX}/etc/env.d/sommelier

      #{@help}

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
