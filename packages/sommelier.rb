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
  depends_on 'xsetroot'
  depends_on 'llvm' => :build
  depends_on 'meson' => :build

  LD_SO_ARCH = if ARCH == 'armv7l' || ARCH == 'aarch64' then 'armhf' else ARCH end

  def self.build

  system 'curl https://chromium.googlesource.com/chromiumos/platform2/+archive/c6f85a3472584df37fcf2d3d99474081f29256cd.tar.gz | tar mzx --warning=no-timestamp'
  Dir.chdir ("vm_tools/sommelier") do
      # Using method here to download single file from googlesource in lieu of 
      # checking out the ChromeOS kernel tree submodule:
      #system 'curl "https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/master/include/uapi/linux/virtwl.h?format=TEXT" | base64 --decode > virtwl.h'


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
      system 'base64 --decode virtwl.h_base64 > virtwl.h'
    end

      system "sed -i '/virtwl.h/d' sommelier.cc"
      system "sed -i '/virtwl.h/d' sommelier-compositor.cc"
      system "sed -i '/virtwl.h/d' sommelier-data-device-manager.cc"
      
      system "sed -i '/linux-dmabuf-unstable-v1-client-protocol.h/a #include \"virtwl.h\"' sommelier.cc"
      system "sed -i '/linux-dmabuf-unstable-v1-client-protocol.h/a #include \"virtwl.h\"' sommelier-compositor.cc"
      system "sed -i '/wayland-client.h/a #include \"virtwl.h\"' sommelier-data-device-manager.cc"

      
      # lld is needed so system libraries can be linked against, since those are required for graphics acceleration.
      ENV['CFLAGS'] = "-fuse-ld=lld"
      ENV['CXXFLAGS'] = "-fuse-ld=lld"

      system "meson #{CREW_MESON_OPTIONS} -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland -Dxwayland_gl_driver_path=#{CREW_LIB_PREFIX}/dri -Ddefault_library=both -Dxwayland_shm_driver=noop -Dshm_driver=noop -Dvirtwl_device=/dev/null -Dpeer_cmd_prefix=/#{ARCH_LIB}/ld-linux-#{LD_SO_ARCH}.so.2 build"
      system "meson configure build"
      system "ninja -C build"
      Dir.chdir ("build") do
	      system 'curl "https://chromium.googlesource.com/chromiumos/containers/sommelier/+/refs/heads/master/sommelierrc?format=TEXT" | base64 --decode > sommelierrc'

	      system "echo 'GDK_BACKEND=x11' > .sommelier.env"
	      system "echo 'CLUTTER_BACKEND=wayland' >> .sommelier.env"
	      system "echo 'XDG_RUNTIME_DIR=/var/run/chrome' >> .sommelier.env"
	      system "echo 'WAYLAND_DISPLAY=wayland-0' >> .sommelier.env"
	      system "echo 'DISPLAY=:0' >> .sommelier.env"
	      # Changing this to 0.5 since otherwise everything looks small on a HiDPI screen.
	      system "echo 'SCALE=0.5' >> .sommelier.env"
        case ARCH
          when 'i686', 'x86_64'
            system "echo '# Following is only needed when kernel < 4.16' >> .sommelier.env"
            system "echo '# since the mesa iris driver no longer supports earlier kernels.' >> .sommelier.env"
            system "echo 'MESA_LOADER_DRIVER_OVERRIDE=i965' >> .sommelier.env"
        end

        system "echo '#!/bin/bash' > sommelierd"
        # As per https://www.reddit.com/r/chromeos/comments/8r5pvh/crouton_sommelier_openjdk_and_oracle_sql/e0pfknx/
        # One needs a second sommelier instance for wayland clients since at some point wl-drm was not implemented
        # in ChromeOS's wayland compositor. But the following isn't working, so disable for now.
        system "echo '#sommelier --master --peer-cmd-prefix=/#{ARCH_LIB}/ld-linux-#{LD_SO_ARCH}.so.2 --drm-device=/dev/dri/renderD128 --shm-driver=noop --data-driver=noop --display=wayland-0 --socket=wayland-1 --virtwl-device=/dev/null > /dev/null 2>&1 &' >> sommelierd"
        system "echo 'sommelier -X --x-display=\$DISPLAY --scale=\$SCALE --glamor --drm-device=/dev/dri/renderD128 --virtwl-device=/dev/null --shm-driver=noop --data-driver=noop --display=wayland-0 --xwayland-path=/usr/local/bin/Xwayland --peer-cmd-prefix=/#{ARCH_LIB}/ld-linux-x86-64.so.2 --no-exit-with-child /bin/sh -c \"#{CREW_PREFIX}/etc/sommelierrc\" &>/dev/null' >> sommelierd"
        
        system "echo '#!/bin/bash' > initsommelier"
        system "echo 'SOMM=\$(pidof sommelier 2> /dev/null)' >> initsommelier"
        system "echo 'if [ -z \"\$SOMM\" ]; then' >> initsommelier"
        system "echo '  [ -f #{CREW_PREFIX}/bin/stopbroadway ] && stopbroadway' >> initsommelier"
        system "echo '  #{CREW_PREFIX}/sbin/sommelierd &' >> initsommelier"
        system "echo '  sleep 3' >> initsommelier"
        system "echo 'fi' >> initsommelier"
        system "echo 'SOMM=\$(pidof sommelier 2> /dev/null)' >> initsommelier"
        system "echo 'if [ ! -z \"\$SOMM\" ]; then' >> initsommelier"
        system "echo '  echo \"sommelier process \$SOMM is running\"' >> initsommelier"
        system "echo 'else' >> initsommelier"
        system "echo '  echo \"sommelier failed to start\"' >> initsommelier"
        system "echo '  exit 1' >> initsommelier"
        system "echo 'fi' >> initsommelier"
        
        system "echo '#!/bin/bash' > startsommelier"
        system "echo 'set -a && source ~/.sommelier.env && set +a && initsommelier' >> startsommelier"
        
        system "echo '#!/bin/bash' > stopsommelier"
        system "echo 'SOMM=\$(pidof sommelier 2> /dev/null)' >> stopsommelier"
        system "echo 'if [ ! -z \"\$SOMM\" ]; then' >> stopsommelier"
        system "echo '  killall -g sommelier' >> stopsommelier"
        system "echo '  sleep 3' >> stopsommelier"
        system "echo 'fi' >> stopsommelier"
        system "echo 'SOMM=\$(pidof sommelier 2> /dev/null)' >> stopsommelier"
        system "echo 'if [ -z \"\$SOMM\" ]; then' >> stopsommelier"
        system "echo '  echo \"sommelier process stopped\"' >> stopsommelier"
        system "echo 'else' >> stopsommelier"
        system "echo '  echo \"sommelier process \$SOMM is running\"' >> stopsommelier"
        system "echo '  exit 1' >> stopsommelier"
        system "echo 'fi' >> stopsommelier"
        
        system "echo '#!/bin/bash' > restartsommelier"
        system "echo 'stopsommelier && startsommelier' >> restartsommelier"
      end
    end
  end

  def self.install
    Dir.chdir ("vm_tools/sommelier") do
      system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
      Dir.chdir ("build") do
        system "install -Dm755 sommelierd #{CREW_DEST_PREFIX}/sbin/sommelierd"
        system "install -Dm755 initsommelier #{CREW_DEST_PREFIX}/bin/initsommelier"
        system "install -Dm755 startsommelier #{CREW_DEST_PREFIX}/bin/startsommelier"
        system "install -Dm755 stopsommelier #{CREW_DEST_PREFIX}/bin/stopsommelier"
        system "install -Dm755 restartsommelier #{CREW_DEST_PREFIX}/bin/restartsommelier"
        system "install -Dm644 .sommelier.env #{CREW_DEST_HOME}/.sommelier.env"
        system "install -Dm755 sommelierrc #{CREW_DEST_PREFIX}/etc/sommelierrc"
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
    puts "echo 'startsommelier' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To start the sommelier daemon, run 'startsommelier'".lightblue
    puts "To stop the sommelier daemon, run 'stopsommelier'".lightblue
    puts "To restart the sommelier daemon, run 'restartsommelier'".lightblue
    puts
    puts "To adjust environment variables, edit ~/.sommelier.env".lightblue
    puts
    puts "You may need to adjust the SCALE environment variable to get the correct screen size.".lightblue
    puts "Please be aware that gui applications may not work without the sommelier daemon running.".orange
    puts
    puts "The sommelier daemon may also have to be restarted with 'restartsommelier' after waking your device.".red
    puts
    puts "If you are upgrading from an earlier version of sommelier, run 'restartsommelier' .".orange
    puts
  end
end
