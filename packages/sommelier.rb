require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 and Wayland programs to the built-in ChromeOS wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/containers/sommelier'
  version '1382ce-1'
  source_url 'https://chromium.googlesource.com/chromiumos/containers/sommelier/+/0.20/README?format=TEXT'
  source_sha256 'b58d799b16d20abf92369fe0749c73f7398996f0afa9933517051778a8bb16c3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-1382ce-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-1382ce-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-1382ce-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-1382ce-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '54fd051594c0f62a1b8af107c23432b7a12a961450741d2c40fe5b5453ae3a10',
     armv7l: '54fd051594c0f62a1b8af107c23432b7a12a961450741d2c40fe5b5453ae3a10',
       i686: 'a6a00941d0a7c22059bc44e1bc9fd766d0bca2168c96c0ac825f7d4779f7c929',
     x86_64: 'd46cfd42ff7f05de3096235ec89d297687202a929edb731e2f7532eec8d4e7eb',
  })

  depends_on 'mesa'
  depends_on 'pixman'
  depends_on 'libxkbcommon'
  depends_on 'xwayland'
  depends_on 'xkbcomp'
  
  def self.build
    system 'git clone https://chromium.googlesource.com/chromiumos/containers/sommelier'
    Dir.chdir ("sommelier") do
      system "git reset --hard 1382ce084cc40790340d672e8b62ec47733cb860"
      system "sed -i 's,/lib/,/#{ARCH_LIB}/,g' Makefile"
      system "sed -i 's,-I.,-I. -I#{CREW_PREFIX}/include/pixman-1,g' Makefile"
      system "make PREFIX=#{CREW_PREFIX} SYSCONFDIR=#{CREW_PREFIX}/etc"
      system "echo '#!/bin/bash' > sommelierd"
      system "echo 'sommelier -X --x-display=\$DISPLAY --no-exit-with-child /bin/sh -c \"#{CREW_PREFIX}/etc/sommelierrc\"' >> sommelierd"
    end
  end

  def self.install
    Dir.chdir ("sommelier") do
      system "make", "PREFIX=#{CREW_PREFIX}", "SYSCONFDIR=#{CREW_PREFIX}/etc", "DESTDIR=#{CREW_DEST_DIR}", "install"
      system "install -Dm755 sommelierd #{CREW_DEST_PREFIX}/sbin/sommelierd"
    end
  end

  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo '# Sommelier environment variables + daemon' >> ~/.bashrc".lightblue
    puts "echo '# See https://github.com/dnschneid/crouton/wiki/Sommelier-(A-more-native-alternative-to-xiwi)' >> ~/.bashrc".lightblue
    puts "echo 'export GDK_BACKEND=wayland' >> ~/.bashrc".lightblue
    puts "echo 'export CLUTTER_BACKEND=wayland' >> ~/.bashrc".lightblue
    puts "echo 'export XDG_RUNTIME_DIR=/var/run/chrome' >> ~/.bashrc".lightblue
    puts "echo 'export WAYLAND_DISPLAY=wayland-0' >> ~/.bashrc".lightblue
    puts "echo 'export DISPLAY=:0' >> ~/.bashrc".lightblue
    puts "echo 'if [ ! -d /tmp/.X11-unix ]; then' >> ~/.bashrc".lightblue
    puts "echo 'mkdir /tmp/.X11-unix' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "echo 'chmod -R 1777 /tmp/.X11-unix' >> ~/.bashrc".lightblue
    puts "echo 'sudo chown root:root /tmp/.X11-unix' >> ~/.bashrc".lightblue
    puts "echo 'if ! pgrep -x \"sommelier\" > /dev/null' >> ~/.bashrc".lightblue
    puts "echo 'then' >> ~/.bashrc".lightblue
    puts "echo '#{CREW_PREFIX}/sbin/sommelierd &' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
