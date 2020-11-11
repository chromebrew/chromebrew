require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 and Wayland programs to the built-in ChromeOS wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/'
  version '20201025'
  compatibility 'all'
  source_url 'https://chromium-review.googlesource.com/changes/chromiumos%2Fplatform2~2476815/revisions/5/patch?zip&path=%2FCOMMIT_MSG'
  source_sha256 'd1850e1d4a1e1ec873b9e4add7a881e981f6c0bc17dfd2a1b85efd7df6dd84b4'

# See merged at in source url to goto find actual tgz url used, which for some reason doesn't seem to have a stable sha256sum.

  depends_on 'mesa'
  depends_on 'xkbcomp'
  depends_on 'xorg_server' 
  depends_on 'psmisc'
  depends_on 'vim' # Until there is a standalone package providing xxd
  depends_on 'xdpyinfo'
  depends_on 'xauth'
  depends_on 'xsetroot'
  depends_on 'llvm' => :build

  PEER_CMD_PREFIX = if ARCH == 'armv7l' || ARCH == 'aarch64' then '/lib/ld-linux-armhf.so.3' elsif ARCH == 'i686' then '/lib/ld-linux-i686.so.2' else '/lib64/ld-linux-x86-64.so.2' end

  def self.build
    # There is no good way to checksum the googlesource tgz file, as they appear to be generated on the fly
    # and checksums vary with each download.
    system 'curl https://chromium.googlesource.com/chromiumos/platform2/+archive/c6f85a3472584df37fcf2d3d99474081f29256cd.tar.gz | tar mzx --warning=no-timestamp'
    Dir.chdir ("vm_tools/sommelier") do
    
    # Google's sommelier expects to find virtwl.h in their kernel source includes, but we may not have
    # set of kernel headers which match, so we just download virtwl.h and then patch the sommelier source
    # to look for the file locally.
    ######################### Download virtwl.h from Chromium 5.4 kernel tree ###########################################
    url_virtwl = "https://chromium.googlesource.com/chromiumos/third_party/kernel/+/5d641a7b7b64664230d2fd2aa1e74dd792b8b7bf/include/uapi/linux/virtwl.h?format=TEXT"
    uri_virtwl = URI.parse url_virtwl
    #filename_virtwl = File.basename(uri_virtwl.path)
    filename_virtwl = 'virtwl.h_base64'
    sha256sum_virtwl = 'a8215f4946ccf30cbd61fcf2ecc4edfe6d05bffeee0bacadd910455274955446'
    
    if File.exist?(filename_virtwl) && Digest::SHA256.hexdigest( File.read("./#{filename_virtwl}") ) == sha256sum_virtwl
      puts "Unpacking virtwl source code".yellow
    else
      puts "Downloading virtwl".yellow
      system('curl', '-s', '-C', '-', '--insecure', '-L', '-#', url_virtwl, '-o', filename_virtwl)
      abort 'Checksum mismatch. :/ Try again.'.lightred unless
        Digest::SHA256.hexdigest( File.read("./#{filename_virtwl}") ) == sha256sum_virtwl
      puts "virtwl archive downloaded".lightgreen
      system 'mkdir -p build/linux'
      system 'base64 --decode virtwl.h_base64 > build/linux/virtwl.h'
    end    
    
    # lld is needed so libraries linked to system libraries (e.g. libgbm.so) can be linked against, since those are required for graphics acceleration.
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    
    system "meson #{CREW_MESON_OPTIONS} -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland -Dxwayland_gl_driver_path=#{CREW_LIB_PREFIX}/dri -Ddefault_library=both -Dxwayland_shm_driver=noop -Dshm_driver=noop -Dvirtwl_device=/dev/null -Dpeer_cmd_prefix=\"#{CREW_PREFIX}#{PEER_CMD_PREFIX}\" build"
    system "meson configure build"
    system "ninja -C build"
    
    Dir.chdir ("build") do
      system 'curl "https://chromium.googlesource.com/chromiumos/containers/sommelier/+/refs/heads/master/sommelierrc?format=TEXT" | base64 --decode > sommelierrc'
      
      # Following is to try to adhere to ChromeOS noexec
      # set on the home dir as per 
      # https://chromium.googlesource.com/chromiumos/docs/+/master/security/noexec_shell_scripts.md
      system 'mkdir -p .sommelier'
      system "echo 'wayland' >> .sommelier/CLUTTER_BACKEND"
      system "echo ':0' >> .sommelier/DISPLAY"
      system "echo 'x11' > .sommelier/GDK_BACKEND"
      system "echo 'wayland-1' >> .sommelier/WAYLAND_DISPLAY"
      system "echo '/var/run/chrome' >> .sommelier/XDG_RUNTIME_DIR"
      # Changing this to 0.5 since otherwise everything looks small on a HiDPI screen.
      system "echo '0.5' >> .sommelier/SCALE"
      
      system "touch .sommelier/MESA_LOADER_DRIVER_OVERRIDE"
      case ARCH
        when 'i686', 'x86_64'
        # Following is only needed when kernel < 4.16
        # since the mesa iris driver no longer supports earlier kernels.
        system "echo 'i965' >> .sommelier/MESA_LOADER_DRIVER_OVERRIDE"
      end
      
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
pkill -f sommelier.elf &>/dev/null
# As per https://www.reddit.com/r/chromeos/comments/8r5pvh/crouton_sommelier_openjdk_and_oracle_sql/e0pfknx/
# One needs a second sommelier instance for wayland clients since at some point wl-drm was not implemented
# in ChromeOS's wayland compositor.      
sommelier --master --peer-cmd-prefix=\"#{CREW_PREFIX}#{PEER_CMD_PREFIX}\" --drm-device=/dev/dri/renderD128 --shm-driver=noop --data-driver=noop --display=wayland-0 --socket=wayland-1 --virtwl-device=/dev/null > /tmp/sommelier.log 2>&1 &
sommelier -X --x-display=\\$DISPLAY  --scale=\$SCALE --glamor --drm-device=/dev/dri/renderD128 --virtwl-device=/dev/null --shm-driver=noop --data-driver=noop --display=wayland-1 --xwayland-path=/usr/local/bin/Xwayland --peer-cmd-prefix=\"#{CREW_PREFIX}#{PEER_CMD_PREFIX}\" --x-auth=~/.Xauthority --no-exit-with-child /bin/sh -c \"touch ~/.Xauthority; xauth -f ~/.Xauthority add $DISPLAY . $(xxd -l 16 -p /dev/urandom); . #{CREW_PREFIX}/etc/sommelierrc\" &>>/tmp/sommelier.log
EOF"

      # startsommelier
       system "cat <<'EOF'> startsommelier
#!/bin/bash
for i in $(ls ~/.sommelier)
do
export $i=\"$(cat ~/.sommelier/\$i 2>/dev/null || :)\"
done
SOMM=$(pgrep -fc sommelier.elf 2> /dev/null)
if [[ \"$SOMM\" == \"0\" ]]; then
  [ -f  #{CREW_PREFIX}/bin/stopbroadway ] && stopbroadway
  #{CREW_PREFIX}/sbin/sommelierd > /dev/null 2>&1 &
fi
wait=3
until [[ \"$(pgrep -fc sommelier.elf)\" == \"2\" ]]
do
  [[ \"$wait\" -le \"0\" ]] && break
  (( wait = wait - 1 ))
sleep 1
done
SOMMPIDS=$(pgrep -f sommelier.elf 2> /dev/null)
if [[ \"$(pgrep -fc sommelier.elf 2> /dev/null)\" == \"2\" ]]; then
  echo \"sommelier processes running: $(echo $SOMMPIDS)\"
else
  echo \"sommelier failed to start\"
  exit 1
fi
EOF"

      # stopsommelier
      system "cat <<'EOF'> stopsommelier
#!/bin/bash
SOMM=$(pgrep -fc sommelier.elf 2> /dev/null)
if [[ \"$SOMM\" -gt \"0\" ]]; then
  pkill -f sommelier.elf &>/dev/null
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
        system "install -Dm644 .sommelier/CLUTTER_BACKEND #{CREW_DEST_HOME}/.sommelier/CLUTTER_BACKEND"
        system "install -Dm644 .sommelier/DISPLAY #{CREW_DEST_HOME}/.sommelier/DISPLAY"
        system "install -Dm644 .sommelier/GDK_BACKEND #{CREW_DEST_HOME}/.sommelier/GDK_BACKEND"
        system "install -Dm644 .sommelier/MESA_LOADER_DRIVER_OVERRIDE #{CREW_DEST_HOME}/.sommelier/MESA_LOADER_DRIVER_OVERRIDE"
        system "install -Dm644 .sommelier/SCALE #{CREW_DEST_HOME}/.sommelier/SCALE"
        system "install -Dm644 .sommelier/WAYLAND_DISPLAY #{CREW_DEST_HOME}/.sommelier/WAYLAND_DISPLAY"
        system "install -Dm644 .sommelier/XDG_RUNTIME_DIR #{CREW_DEST_HOME}/.sommelier/XDG_RUNTIME_DIR"

      end
    end
  end
  
  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo '# Sommelier environment variables + daemon' >> ~/.bashrc".lightblue
    puts "echo '# See https://github.com/dnschneid/crouton/wiki/Sommelier-(A-more-native-alternative-to-xiwi)' >> ~/.bashrc".lightblue
    puts "echo 'if [ ! -d /tmp/.X11-unix ]; then' >> ~/.bashrc".lightblue
    puts "echo 'mkdir /tmp/.X11-unix' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "echo 'sudo chmod -R 1777 /tmp/.X11-unix' >> ~/.bashrc".lightblue
    puts "echo 'sudo chown root:root /tmp/.X11-unix' >> ~/.bashrc".lightblue
    puts "echo 'for i in \$(ls ~/.sommelier)'  >> ~/.bashrc".lightblue
    puts "echo 'do'  >> ~/.bashrc".lightblue
    puts "echo 'export \$i=\"\$(cat ~/.sommelier/\$i 2>/dev/null || :)\"'  >> ~/.bashrc".lightblue
    puts "echo 'done'  >> ~/.bashrc".lightblue
    puts "echo 'if ! xdpyinfo -display \$DISPLAY &>/dev/null ; then stopsommelier && startsommelier; else startsommelier; fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To adjust environment variables, edit files in ~/.sommelier/".lightblue
    puts "e.g. You may need to adjust the SCALE environment variable to get the correct screen size.".lightblue
    puts
    puts "To start the sommelier daemon, run 'startsommelier'".lightblue
    puts "To stop the sommelier daemon, run 'stopsommelier'".lightblue
    puts "To restart the sommelier daemon, run 'restartsommelier'".lightblue
    puts
    puts "Please be aware that gui applications may not work without the sommelier daemon running.".orange
    puts
    puts "The sommelier daemon may also have to be restarted with 'restartsommelier' after waking your device.".red
    puts
    puts "If you are upgrading from an earlier version of sommelier, run 'restartsommelier' .".orange
    puts
  end
end
