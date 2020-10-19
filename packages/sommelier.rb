require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 and Wayland programs to the built-in ChromeOS wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/sommelier/'
  version '2237607'
  compatibility 'all'
  #source_url 'https://chromium-review.googlesource.com/changes/chromiumos%2Fplatform2~2333733/revisions/31/patch?zip&path=%2FCOMMIT_MSG'
  source_url 'https://chromium-review.googlesource.com/changes/chromiumos%2Fplatform2~2237607/revisions/10/patch?zip&path=%2FCOMMIT_MSG'
  source_sha256 '0dda9635fe947383e0a4abc573a289acbd81e07115dbb1aaafcc7f3b85a35d6a'

# See merged at in source url to goto find actual tgz url used, which for some reason doesn't seem to have a stable sha256sum.

  depends_on 'mesa'
  depends_on 'xkbcomp'
  depends_on 'xorg_server'
  depends_on 'psmisc'
  depends_on 'xsetroot'
  depends_on 'llvm' => ':build'
  depends_on 'meson' => ':build'

  def self.build
  # Using method here to download single file from googlesource in lieu of 
  # checking out the ChromeOS kernel tree submodule:
  # https://chromium-review.googlesource.com/c/chromiumos/platform2/+/2237607
  system 'curl https://chromium.googlesource.com/chromiumos/platform2/+archive/be4e16feb380360cabbb5d6199a09592ecaf4a42.tar.gz | tar mzx --warning=no-timestamp'
  Dir.chdir ("vm_tools/sommelier") do
      system 'curl "https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/master/include/uapi/linux/virtwl.h?format=TEXT" | base64 --decode > virtwl.h'
      system "sed -i '/virtwl.h/d' sommelier.c"
      system "sed -i '/linux-dmabuf-unstable-v1-client-protocol.h/a #include \"virtwl.h\"' sommelier.c"
      # Clang is needed so system libraries can be linked against, since those are required for graphics acceleration.
      ENV['CC'] = 'clang'
      ENV['CXX'] = 'clang'

      system "meson",
		"-Dprefix=#{CREW_PREFIX}",
		"-Dlibdir=#{CREW_LIB_PREFIX}-test",
		"-Ddatadir=#{CREW_LIB_PREFIX}-test",
		"-Dsysconfdir=#{CREW_PREFIX}/etc",
		"-Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland",
		"-Dxwayland_gl_driver_path=#{CREW_LIB_PREFIX}/dri",
		"-Dsharedstatedir=#{CREW_LIB_PREFIX}",
		"-Dlocalstatedir=#{CREW_LIB_PREFIX}",
		"-Dvirtwl_device=/dev/null",
		"-Dbuildtype=release",
		"build"
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
              system "echo '#sommelier --master --peer-cmd-prefix=/#{ARCH_LIB}/ld-linux-x86-64.so.2 --drm-device=/dev/dri/renderD128 --shm-driver=noop --data-driver=noop --display=wayland-0 --socket=wayland-1 --virtwl-device=/dev/null > /dev/null 2>&1 &' >> sommelierd"
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
      end
    end
  end

  def self.install
    Dir.chdir ("vm_tools/sommelier") do
      system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
      Dir.chdir ("build") do
	      system "install -Dm755 sommelierd #{CREW_DEST_PREFIX}/sbin/sommelierd"
	      system "install -Dm755 initsommelier #{CREW_DEST_PREFIX}/bin/initsommelier"
	      system "install -Dm755 stopsommelier #{CREW_DEST_PREFIX}/bin/stopsommelier"
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
    puts "echo 'alias startsommelier=\"set -a && source ~/.sommelier.env && set +a && initsommelier\"' >> ~/.bashrc".lightblue
    puts "echo 'alias restartsommelier=\"stopsommelier && startsommelier\"'  >> ~/.bashrc".lightblue
    puts "echo 'startsommelier' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To start the sommelier daemon, run 'startsommelier'".lightblue
    puts "To stop the sommelier daemon, run 'stopsommelier'".lightblue
    puts
    puts "To adjust environment variables, edit ~/.sommelier.env".lightblue
    puts
    puts "You may need to adjust the SCALE environment variable to get the correct screen size.".lightblue
    puts
    puts "Please be aware that gui applications may not work without the sommelier daemon running.".orange
    puts
    puts "If you are upgrading from an earlier version of sommelier, run".orange
    puts "'stopsommelier && startsommelier' or logout and login again.".orange
    puts
  end
end
