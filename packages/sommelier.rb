require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 programs to the built-in ChromeOS Exo Wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/'
  version '20210109-2'
  license 'BSD-Google'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-20210109-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-20210109-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-20210109-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-20210109-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b518f2f3086e611f6bcdd8cd2b8b67d70956b96c5c43174e26685be6bd7aa0c4',
     armv7l: 'b518f2f3086e611f6bcdd8cd2b8b67d70956b96c5c43174e26685be6bd7aa0c4',
       i686: '74a2838593c1297e37127335d6e2aad9402caf264960bf05405434cec67eb254',
     x86_64: '7e9689e28331c1d9be1f30c9deb6a77fae2519ccb753ef0ffb53faac324bf7e8'
  })

  depends_on 'coreutils' # for readlink in wrapper script
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
  depends_on 'xdpyinfo' # for xdpyinfo in wrapper script
  depends_on 'xsetroot' # for xsetroot in sommelierrc script
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

  def self.prebuild
    @git_dir = 'platform2_git'
    @git_hash = 'f3b2e2b6a8327baa2e62ef61036658c258ab4a09'
    @git_url = 'https://chromium.googlesource.com/chromiumos/platform2'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
    end
  end

  def self.build
    Dir.chdir('platform2_git/vm_tools/sommelier') do
      # Patch to avoid error with GCC > 9.x
      # ../sommelier.cc:3238:10: warning: ‘char* strncpy(char*, const char*, size_t)’ specified bound 108 equals destination size [-Wstringop-truncation]
      system "sed -i 's/sizeof(addr.sun_path))/sizeof(addr.sun_path) - 1)/' sommelier.cc"

      # lld is needed so libraries linked to system libraries (e.g. libgbm.so) can be linked against, since those are required for graphics acceleration.

      system "env CC=clang CXX=clang++ \
        meson #{CREW_MESON_OPTIONS} \
        -Db_asneeded=false \
        -Db_lto=true \
        -Db_lto_mode=thin \
        -Dc_args='-fuse-ld=lld' \
        -Dcpp_args='-fuse-ld=lld' \
        -Dcpp_link_args='-fuse-ld=lld' \
        -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland \
        -Dxwayland_gl_driver_path=/usr/#{ARCH_LIB}/dri -Ddefault_library=both \
        -Dxwayland_shm_driver=noop -Dshm_driver=noop -Dvirtwl_device=/dev/null \
        -Dpeer_cmd_prefix=\"#{CREW_PREFIX}#{@peer_cmd_prefix}\" \
        builddir"
      system 'meson configure builddir'
      system 'ninja -C builddir'

      Dir.chdir('builddir') do
        system 'curl -L "https://chromium.googlesource.com/chromiumos/containers/sommelier/+/fbdefff6230026ac333eac0924d71cf824e6ecd8/sommelierrc?format=TEXT" | base64 --decode > sommelierrc'

        system "cat <<'EOF'> .sommelier-default.env
#!/bin/bash
shopt -os allexport
CLUTTER_BACKEND=wayland
DISPLAY=:0
GDK_BACKEND=x11
SCALE=1
SOMMELIER_ACCELERATORS=\"Super_L,<Alt>bracketleft,<Alt>bracketright\"
WAYLAND_DISPLAY=wayland-0
XDG_RUNTIME_DIR=/var/run/chrome
shopt -ou allexport
UNAME_ARCH=$(uname -m)
if [[ \"$UNAME_ARCH\" == 'x86_64' ]] || [[ \"$UNAME_ARCH\" == 'i686' ]]
then
  declare -a VERTEMP
  TEMP1=$(uname -r)
  VERTEMP=(${TEMP1//[.-]/ })
  VERSION=$(((${VERTEMP[0]} * 1000000)\\
        + (${VERTEMP[1]} * 10000)\\
        + ${VERTEMP[2]}))
  if [[ \"$VERSION\" -lt '4160000' ]]
  then
      export MESA_LOADER_DRIVER_OVERRIDE=i965
  fi
fi
EOF"

        # Create local startup and shutdown scripts

        # sommelier_sh
        # This file via:
        # crostini: /opt/google/cros-containers/bin/sommelier
        # https://source.chromium.org/chromium/chromium/src/+/master:third_party/chromite/third_party/lddtree.py;drc=46da9a8dfce28c96765dc7d061f0c6d7a52e7352;l=146
        system "cat <<'EOF'> sommelier_sh
#!/bin/bash
if base=$(readlink \"$0\" 2>/dev/null); then
  case $base in
  /*) base=$(readlink -f \"$0\" 2>/dev/null);; # if $0 is abspath symlink, make symlink fully resolved.
  *)  base=$(dirname \"$0\")/\"${base}\";;
  esac
else
  case $0 in
  /*) base=$0;;
  *)  base=${PWD:-`pwd`}/$0;;
  esac
fi
basedir=${base%/*}
# TODO(crbug/1003841): Remove LD_ARGV0 once
# ld.so supports forwarding the binary name.
LD_ARGV0=\"$0\" LD_ARGV0_REL=\"../bin/sommelier\" exec   \"${basedir}/..#{@peer_cmd_prefix}\"   --library-path \"${basedir}/../#{ARCH_LIB}\"   --inhibit-rpath ''   \"${base}.elf\"   \"$@\"
EOF"
        # sommelierd
        system "cat <<'EOF'> sommelierd
#!/bin/bash
set -a
source ~/.sommelier-default.env &>/dev/null
source ~/.sommelier.env &>/dev/null
set +a
mkdir -p #{CREW_PREFIX}/var/{log,run}
checksommelierwayland () {
  [[ -f \"#{CREW_PREFIX}/var/run/sommelier-wayland.pid\" ]] || return 1
  /sbin/ss --unix -a -p | grep \"\\b\$(cat #{CREW_PREFIX}/var/run/sommelier-wayland.pid)\" | grep wayland &>/dev/null
}
checksommelierxwayland () {
  xdpyinfo -display \$DISPLAY &>/dev/null
}
## As per https://www.reddit.com/r/chromeos/comments/8r5pvh/crouton_sommelier_openjdk_and_oracle_sql/e0pfknx/
## One needs a second sommelier instance for wayland clients since at some point wl-drm was not implemented
## in ChromeOS's wayland compositor.
#if ! checksommelierwayland ; then
#pkill -F #{CREW_PREFIX}/var/run/sommelier-wayland.pid &>/dev/null
#rm \${XDG_RUNTIME_DIR}/wayland-1*
#sommelier --parent --peer-cmd-prefix=\"#{CREW_PREFIX}#{@peer_cmd_prefix}\" --drm-device=/dev/dri/renderD128 --shm-driver=noop --data-driver=noop --display=wayland-0 --socket=wayland-1 --virtwl-device=/dev/null > #{CREW_PREFIX}/var/log/sommelier.log 2>&1 &
#echo \$! >#{CREW_PREFIX}/var/run/sommelier-wayland.pid
#fi
if ! checksommelierxwayland; then
pkill -F #{CREW_PREFIX}/var/run/sommelier-xwayland.pid &>/dev/null
#[[ ! -d /tmp/.X11-unix ]] && mkdir /tmp/.X11-unix
#sudo chmod -R 1777 /tmp/.X11-unix
#sudo chown root:root /tmp/.X11-unix
DISPLAY=\"\${DISPLAY//:}\"
DISPLAY=\"\${DISPLAY:0:2}\"
#sudo rm /tmp/.X11-unix/X\"\${DISPLAY}\"
sommelier -X --x-display=:\$DISPLAY  --scale=\$SCALE --glamor --drm-device=/dev/dri/renderD128 --virtwl-device=/dev/null --shm-driver=noop --data-driver=noop --display=wayland-0 --xwayland-path=/usr/local/bin/Xwayland --xwayland-gl-driver-path=#{CREW_LIB_PREFIX}/dri --peer-cmd-prefix=\"#{CREW_PREFIX}#{@peer_cmd_prefix}\" --no-exit-with-child /bin/sh -c \"touch ~/.Xauthority; xauth -f ~/.Xauthority add :$DISPLAY . $(xxd -l 16 -p /dev/urandom); . #{CREW_PREFIX}/etc/sommelierrc\" &>>#{CREW_PREFIX}/var/log/sommelier.log
echo \$! >#{CREW_PREFIX}/var/run/sommelier-xwayland.pid
xhost +si:localuser:root &>/dev/null
fi
EOF"
        # startsommelier
        system "cat <<'EOF'> startsommelier
#!/bin/bash
set -a
source ~/.sommelier-default.env &>/dev/null
source ~/.sommelier.env &>/dev/null
set +a
checksommelierwayland () {
  #[[ -f \"#{CREW_PREFIX}/var/run/sommelier-wayland.pid\" ]] || return 1
  #/sbin/ss --unix -a -p | grep \"\\b\$(cat #{CREW_PREFIX}/var/run/sommelier-wayland.pid)\" | grep wayland &>/dev/null
  return 0
}
checksommelierxwayland () {
  xdpyinfo -display \$DISPLAY &>/dev/null
}
if ! checksommelierwayland || ! checksommelierxwayland ; then
  [ -f  #{CREW_PREFIX}/bin/stopbroadway ] && stopbroadway
  #{CREW_PREFIX}/sbin/sommelierd > /dev/null 2>&1 &
fi
wait=3
until checksommelierwayland && checksommelierxwayland
do
  [[ \"$wait\" -le \"0\" ]] && break
  (( wait = wait - 1 ))
  sleep 1
done
SOMMWPIDS=\$(pgrep -f \"sommelier.elf --parent\" 2> /dev/null)
SOMMWPROCS=\$(pgrep -fa \"sommelier.elf --parent\" 2> /dev/null)
SOMMXPIDS=\$(pgrep -f \"sommelier.elf -X\" 2> /dev/null)
SOMMXPROCS=\$(pgrep -fa \"sommelier.elf -X\" 2> /dev/null)
if checksommelierwayland && checksommelierxwayland ; then
  echo -e \"sommelier processes running: \$(echo \$SOMMWPIDS \$SOMMXPIDS)\"
else
  echo \"some sommelier processes failed to start\"
  echo -e \"sommelier processes running: \$SOMMWPROCS \\n \$SOMMXPROCS\"
  exit 1
fi
EOF"
        # stopsommelier
        system "cat <<'EOF'> stopsommelier
#!/bin/bash
SOMM=\$(pgrep -fc sommelier.elf 2> /dev/null)
if [[ \"$SOMM\" -gt \"0\" ]]; then
  pkill -f sommelier.elf &>/dev/null
  pkill -F #{CREW_PREFIX}/var/run/sommelier-wayland.pid &>/dev/null
  pkill -F #{CREW_PREFIX}/var/run/sommelier-xwayland.pid &>/dev/null
else
  exit 0
fi
if [[ \"$(pgrep -fc sommelier.elf 2> /dev/null)\" -gt \"0\" ]]; then
  echo \"sommelier failed to stop\"
  exit 1
else
  echo \"sommelier stopped\"
fi
EOF"
        # restartsommelier
        system "echo '#!/bin/bash' > restartsommelier"
        system "echo 'stopsommelier && startsommelier' >> restartsommelier"
      end
    end
  end

  def self.install
    Dir.chdir('platform2_git/vm_tools/sommelier') do
      system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
      Dir.chdir('builddir') do
        FileUtils.mv "#{CREW_DEST_PREFIX}/bin/sommelier", "#{CREW_DEST_PREFIX}/bin/sommelier.elf"
        system "install -Dm755 sommelier_sh #{CREW_DEST_PREFIX}/bin/sommelier"
        system "install -Dm755 sommelierd #{CREW_DEST_PREFIX}/sbin/sommelierd"
        system "install -Dm755 startsommelier #{CREW_DEST_PREFIX}/bin/startsommelier"
        FileUtils.ln_sf 'startsommelier', "#{CREW_DEST_PREFIX}/bin/initsommelier"
        system "install -Dm755 stopsommelier #{CREW_DEST_PREFIX}/bin/stopsommelier"
        system "install -Dm755 restartsommelier #{CREW_DEST_PREFIX}/bin/restartsommelier"
        system "install -Dm755 sommelierrc #{CREW_DEST_PREFIX}/etc/sommelierrc"
        system "install -Dm644 .sommelier-default.env #{CREW_DEST_HOME}/.sommelier-default.env"
      end
    end

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    @env = <<~EOF
      # Sommelier loading code
      set -a
      source ~/.sommelier-default.env
      source ~/.sommelier.env
      set +a
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/sommelier", @env)
  end

  def self.postinstall
    puts
    # Having ~/.bashrc load sommelier environment variables by default.
    oldsommelier_in_bashrc = `grep -c "set -a && source ~/.sommelier.env && set +a" ~/.bashrc || true`
    unless oldsommelier_in_bashrc.to_i < 1
      puts 'Replacing old sommelier env variable loading code in ~/.bashrc'.lightblue
      system 'sed -i "s,set -a && source ~/.sommelier.env && set +a,set -a ; source ~/.sommelier-default.env ; source ~/.sommelier.env ; set +a,g" -i.backup ~/.bashrc'
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
    end

    sommelier_in_bashrc = `grep -c "set -a ; source ~/.sommelier-default.env ; source ~/.sommelier.env ; set +a" ~/.bashrc || true`
    unless sommelier_in_bashrc.to_i.positive?
      puts 'Putting sommelier loading code in ~/.bashrc'.lightblue
      system "echo '# Sommelier daemon' >> ~/.bashrc"
      system "echo 'startsommelier' >> ~/.bashrc"
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
    end
    puts
    FileUtils.touch "#{HOME}/.sommelier.env" unless File.exist? "#{HOME}/.sommelier.env"
    puts 'To adjust sommelier environment variables, edit ~/.sommelier.env'.lightblue
    puts 'Default values are in ~/.sommelier-default.env'.lightblue
    puts
    puts "To start the sommelier daemon, run 'startsommelier'".lightblue
    puts "To stop the sommelier daemon, run 'stopsommelier'".lightblue
    puts "To restart the sommelier daemon, run 'restartsommelier'".lightblue
    puts
    puts 'Please be aware that gui applications may not work without the'.orange
    puts 'sommelier daemon running.'.orange
    puts
    puts 'The sommelier daemon may also have to be restarted with'.orange
    puts "'restartsommelier' after waking your device.".orange
    puts
    puts '(If you are upgrading from an earlier version of sommelier,'.orange
    puts "also run 'restartsommelier'.)".orange
  end
end
