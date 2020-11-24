require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 and Wayland programs to the built-in ChromeOS wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/'
  version '20201025'
  compatibility 'all'
  source_url 'https://chromium-review.googlesource.com/changes/chromiumos%2Fplatform2~2476815/revisions/5/patch?zip&path=%2FCOMMIT_MSG'
  source_sha256 'd1850e1d4a1e1ec873b9e4add7a881e981f6c0bc17dfd2a1b85efd7df6dd84b4'

  depends_on 'mesa'
  depends_on 'xkbcomp'
  depends_on 'xorg_server' unless File.exists? "#{CREW_PREFIX}/bin/Xwayland.elf"
  depends_on 'xwayland'
  depends_on 'psmisc'
  depends_on 'vim' # Until there is a standalone package providing xxd
  depends_on 'xdpyinfo'
  depends_on 'xauth'
  depends_on 'xsetroot'
  depends_on 'llvm' => :build

  case ARCH
   when 'armv7l', 'aarch64'
      PEER_CMD_PREFIX='/lib/ld-linux-armhf.so.3'
   when 'i686'
      PEER_CMD_PREFIX='/lib/ld-linux-i686.so.2'
   when 'x86_64'
      PEER_CMD_PREFIX='/lib64/ld-linux-x86-64.so.2'
  end
    
  def self.build
    # There is no good way to checksum the googlesource tgz file, as they appear to be generated on the fly
    # and checksums vary with each download.
    system 'curl -L https://chromium.googlesource.com/chromiumos/platform2/+archive/c6f85a3472584df37fcf2d3d99474081f29256cd.tar.gz | tar mzx --warning=no-timestamp'
    Dir.chdir ("vm_tools/sommelier") do
    
    # Google's sommelier expects to find virtwl.h in their kernel source includes, but we may not have
    # set of kernel headers which match, so we just download virtwl.h and then patch the sommelier source
    # to look for the file locally.
    ######################### Download virtwl.h from Chromium 5.4 kernel tree ###########################################
    url_virtwl = "https://chromium.googlesource.com/chromiumos/third_party/kernel/+/5d641a7b7b64664230d2fd2aa1e74dd792b8b7bf/include/uapi/linux/virtwl.h?format=TEXT"
    uri_virtwl = URI.parse url_virtwl
    filename_virtwl = 'virtwl.h_base64'
    sha256sum_virtwl = 'a8215f4946ccf30cbd61fcf2ecc4edfe6d05bffeee0bacadd910455274955446'
    
    puts "Downloading virtwl".yellow
    system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_virtwl, '-o', filename_virtwl)
    abort 'Checksum mismatch. :/ Try again.'.lightred unless
      Digest::SHA256.hexdigest( File.read( filename_virtwl ) ) == sha256sum_virtwl
    puts "virtwl base64 downloaded".lightgreen
    FileUtils.mkdir_p 'build/linux'
    system 'base64 --decode virtwl.h_base64 > build/linux/virtwl.h'   
    
    # Patch to avoid error with GCC > 9.x
    # ../sommelier.cc:3238:10: warning: ‘char* strncpy(char*, const char*, size_t)’ specified bound 108 equals destination size [-Wstringop-truncation]
    system "sed -i 's/sizeof(addr.sun_path))/sizeof(addr.sun_path) - 1)/' sommelier.cc"
    
    # lld is needed so libraries linked to system libraries (e.g. libgbm.so) can be linked against, since those are required for graphics acceleration.
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    
    system "meson #{CREW_MESON_OPTIONS} -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland \
    -Dxwayland_gl_driver_path=/usr/#{ARCH_LIB}/dri -Ddefault_library=both \
    -Dxwayland_shm_driver=noop -Dshm_driver=noop -Dvirtwl_device=/dev/null \
    -Dpeer_cmd_prefix=\"#{CREW_PREFIX}#{PEER_CMD_PREFIX}\" build"
    system "meson configure build"
    system "ninja -C build"
    
    Dir.chdir ("build") do
      system 'curl -L "https://chromium.googlesource.com/chromiumos/containers/sommelier/+/refs/heads/master/sommelierrc?format=TEXT" | base64 --decode > sommelierrc'
      
      system "cat <<'EOF'> .sommelier.env
#!/bin/bash
shopt -os allexport
CLUTTER_BACKEND=wayland
DISPLAY=:0
GDK_BACKEND=x11
SCALE=0.5
SOMMELIER_ACCELERATORS=\"Super_L,<Alt>bracketleft,<Alt>bracketright\"
WAYLAND_DISPLAY=wayland-1
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
      
      #Create local startup and shutdown scripts
      
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
LD_ARGV0=\"$0\" LD_ARGV0_REL=\"../bin/sommelier\" exec   \"${basedir}/..#{PEER_CMD_PREFIX}\"   --library-path \"${basedir}/../#{ARCH_LIB}\"   --inhibit-rpath ''   \"${base}.elf\"   \"$@\"
EOF"

      # sommelierd
      system "cat <<'EOF'> sommelierd
#!/bin/bash
set -a && source ~/.sommelier.env && set +a
mkdir -p #{CREW_PREFIX}/var/{log,run}
checksommelierwayland () {
  /sbin/ss --unix -a -p | grep \"\\b\$(cat #{CREW_PREFIX}/var/run/sommelier-wayland.pid)\" | grep wayland &>/dev/null
}
checksommelierxwayland () {
  xdpyinfo -display \$DISPLAY &>/dev/null
}
# As per https://www.reddit.com/r/chromeos/comments/8r5pvh/crouton_sommelier_openjdk_and_oracle_sql/e0pfknx/
# One needs a second sommelier instance for wayland clients since at some point wl-drm was not implemented
# in ChromeOS's wayland compositor.
if ! checksommelierwayland ; then
pkill -F #{CREW_PREFIX}/var/run/sommelier-wayland.pid &>/dev/null
sudo rm \${XDG_RUNTIME_DIR}/wayland-1*
sommelier --master --peer-cmd-prefix=\"#{CREW_PREFIX}#{PEER_CMD_PREFIX}\" --drm-device=/dev/dri/renderD128 --shm-driver=noop --data-driver=noop --display=wayland-0 --socket=wayland-1 --virtwl-device=/dev/null > #{CREW_PREFIX}/var/log/sommelier.log 2>&1 &
echo \$! >#{CREW_PREFIX}/var/run/sommelier-wayland.pid
fi
if ! checksommelierxwayland; then
pkill -F #{CREW_PREFIX}/var/run/sommelier-xwayland.pid &>/dev/null
[[ ! -d /tmp/.X11-unix ]] && mkdir /tmp/.X11-unix
sudo chmod -R 1777 /tmp/.X11-unix
sudo chown root:root /tmp/.X11-unix
DISPLAY=\"\${DISPLAY//:}\"
DISPLAY=\"\${DISPLAY:0:2}\"
sudo rm /tmp/.X11-unix/X\"\${DISPLAY}\"
sommelier -X --x-display=:\$DISPLAY  --scale=\$SCALE --glamor --drm-device=/dev/dri/renderD128 --virtwl-device=/dev/null --shm-driver=noop --data-driver=noop --display=wayland-0 --xwayland-path=/usr/local/bin/Xwayland --peer-cmd-prefix=\"#{CREW_PREFIX}#{PEER_CMD_PREFIX}\" --no-exit-with-child /bin/sh -c \"touch ~/.Xauthority; xauth -f ~/.Xauthority add :$DISPLAY . $(xxd -l 16 -p /dev/urandom); . #{CREW_PREFIX}/etc/sommelierrc\" &>>#{CREW_PREFIX}/var/log/sommelier.log
echo \$! >#{CREW_PREFIX}/var/run/sommelier-xwayland.pid
xhost +si:localuser:root &>/dev/null
fi
EOF"

      # startsommelier
       system "cat <<'EOF'> startsommelier
#!/bin/bash
set -a && source ~/.sommelier.env &>/dev/null && set +a
checksommelierwayland () {
  /sbin/ss --unix -a -p | grep \"\\b\$(cat #{CREW_PREFIX}/var/run/sommelier-wayland.pid)\" | grep wayland &>/dev/null
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
SOMMWPIDS=\$(pgrep -f \"sommelier.elf --master\" 2> /dev/null)
SOMMWPROCS=\$(pgrep -fa \"sommelier.elf --master\" 2> /dev/null)
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
    Dir.chdir ("vm_tools/sommelier") do
      system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
      Dir.chdir ("build") do
        FileUtils.mv "#{CREW_DEST_PREFIX}/bin/sommelier", "#{CREW_DEST_PREFIX}/bin/sommelier.elf"
        system "install -Dm755 sommelier_sh #{CREW_DEST_PREFIX}/bin/sommelier"
        system "install -Dm755 sommelierd #{CREW_DEST_PREFIX}/sbin/sommelierd"
        system "install -Dm755 startsommelier #{CREW_DEST_PREFIX}/bin/startsommelier"
        FileUtils.ln_sf 'startsommelier', "#{CREW_DEST_PREFIX}/bin/initsommelier"
        system "install -Dm755 stopsommelier #{CREW_DEST_PREFIX}/bin/stopsommelier"
        system "install -Dm755 restartsommelier #{CREW_DEST_PREFIX}/bin/restartsommelier"
        system "install -Dm755 sommelierrc #{CREW_DEST_PREFIX}/etc/sommelierrc"
        system "install -Dm644 .sommelier.env #{CREW_DEST_HOME}/.sommelier.env"

      end
    end
  end
  
  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo '# Sommelier environment variables + daemon' >> ~/.bashrc".lightblue
    puts "echo '# See https://github.com/dnschneid/crouton/wiki/Sommelier-(A-more-native-alternative-to-xiwi)' >> ~/.bashrc".lightblue
    puts "echo 'set -a && source ~/.sommelier.env && set +a' >> ~/.bashrc".lightblue
    puts "echo 'startsommelier' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To adjust environment variables, edit ~/.sommelier.env".lightblue
    puts "e.g. You may need to adjust the SCALE environment variable to".lightblue
    puts "get the correct screen size.".lightblue
    puts
    puts "To start the sommelier daemon, run 'startsommelier'".lightblue
    puts "To stop the sommelier daemon, run 'stopsommelier'".lightblue
    puts "To restart the sommelier daemon, run 'restartsommelier'".lightblue
    puts
    puts "Please be aware that gui applications may not work without the".orange
    puts "sommelier daemon running.".orange
    puts
    puts "The sommelier daemon may also have to be restarted with".orange
    puts "'restartsommelier'after waking your device.".orange
    puts
    puts "(If you are upgrading from an earlier version of sommelier,".orange
    puts "also run 'restartsommelier'.)".orange
  end
end
