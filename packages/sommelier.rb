require 'package'

class Sommelier < Package
  description 'Sommelier works by redirecting X11 and Wayland programs to the built-in ChromeOS wayland server.'
  homepage 'https://chromium.googlesource.com/chromiumos/containers/sommelier'
  version '1382ce0'
  source_url 'https://chromium.googlesource.com/chromiumos/containers/sommelier/+/0.20/README?format=TEXT'
  source_sha256 'b58d799b16d20abf92369fe0749c73f7398996f0afa9933517051778a8bb16c3'

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-1382ce0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-1382ce0-chromeos-x86_64.tar.xz',
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-1382ce0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sommelier-1382ce0-chromeos-armv7l.tar.xz',
  })
  binary_sha256 ({
       i686: 'd89dd374f3ac1adbd7ba861284506c0b515733dfaa68cb998965f73f8628405b',
     x86_64: '694a58eead61a518cd99c75d580a84c70f8f63ed4d299bc3f9476f937156cf58',
    aarch64: '1ce406e7806f37bddbe971f18acc3992cd55d3e6598b396fc26657dfb1128e24',
     armv7l: '1ce406e7806f37bddbe971f18acc3992cd55d3e6598b396fc26657dfb1128e24',
  })

  depends_on 'mesa'
  depends_on 'pixman'
  depends_on 'libxkbcommon'
  depends_on 'xwayland'
  depends_on 'xkbcomp'
  depends_on 'psmisc'
  
  def self.build
    system 'git clone https://chromium.googlesource.com/chromiumos/containers/sommelier'
    Dir.chdir ("sommelier") do
      system "git reset --hard 1382ce084cc40790340d672e8b62ec47733cb860"
      system "sed -i 's,/lib/,/#{ARCH_LIB}/,g' Makefile"
      system "sed -i 's,-I.,-I. -I#{CREW_PREFIX}/include/pixman-1,g' Makefile"
      system "make PREFIX=#{CREW_PREFIX} SYSCONFDIR=#{CREW_PREFIX}/etc"
      system "echo '#!/bin/bash' > sommelierd"
      system "echo 'sommelier -X --x-display=\$DISPLAY --no-exit-with-child /bin/sh -c \"#{CREW_PREFIX}/etc/sommelierrc\"' >> sommelierd"
      system "echo '#!/bin/bash' > startsommelier"
      system "echo 'SOMM=\$(ps ax | grep \"sommelierrc\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> startsommelier"
      system "echo 'if [ -z \"\$SOMM\" ]; then' >> startsommelier"
      system "echo '  #{CREW_PREFIX}/sbin/sommelierd &' >> startsommelier"
      system "echo '  sleep 3' >> startsommelier"
      system "echo 'fi' >> startsommelier"
      system "echo 'SOMM=\$(ps ax | grep \"sommelierrc\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> startsommelier"
      system "echo 'if [ ! -z \"\$SOMM\" ]; then' >> startsommelier"
      system "echo '  echo \"sommelier process \$SOMM is running\"' >> startsommelier"
      system "echo 'else' >> startsommelier"
      system "echo '  echo \"sommelier failed to start\"' >> startsommelier"
      system "echo '  exit 1' >> startsommelier"
      system "echo 'fi' >> startsommelier"
      system "echo '#!/bin/bash' > stopsommelier"
      system "echo 'SOMM=\$(ps ax | grep \"sommelierrc\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> stopsommelier"
      system "echo 'if [ ! -z \"\$SOMM\" ]; then' >> stopsommelier"
      system "echo '  killall sommelier' >> stopsommelier"
      system "echo '  sleep 3' >> stopsommelier"
      system "echo 'fi' >> stopsommelier"
      system "echo 'SOMM=\$(ps ax | grep \"sommelierrc\" | grep -v grep | xargs | cut -d\" \" -f1 2> /dev/null)' >> stopsommelier"
      system "echo 'if [ -z \"\$SOMM\" ]; then' >> stopsommelier"
      system "echo '  echo \"sommelier process stopped\"' >> stopsommelier"
      system "echo 'else' >> stopsommelier"
      system "echo '  echo \"sommelier process \$SOMM is running\"' >> stopsommelier"
      system "echo '  exit 1' >> stopsommelier"
      system "echo 'fi' >> stopsommelier"
    end
  end

  def self.install
    Dir.chdir ("sommelier") do
      system "make", "PREFIX=#{CREW_PREFIX}", "SYSCONFDIR=#{CREW_PREFIX}/etc", "DESTDIR=#{CREW_DEST_DIR}", "install"
      system "install -Dm755 sommelierd #{CREW_DEST_PREFIX}/sbin/sommelierd"
      system "install -Dm755 startsommelier #{CREW_DEST_PREFIX}/bin/startsommelier"
      system "install -Dm755 stopsommelier #{CREW_DEST_PREFIX}/bin/stopsommelier"
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
    puts "echo 'sudo chmod -R 1777 /tmp/.X11-unix' >> ~/.bashrc".lightblue
    puts "echo 'sudo chown root:root /tmp/.X11-unix' >> ~/.bashrc".lightblue
    puts "echo 'startsommelier' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To start the sommelier daemon, run 'startsommelier'".lightblue
    puts "To stop the sommelier daemon, run 'stopsommelier'".lightblue
    puts
    puts "Please be aware that gui applications may not work without the sommelier daemon running.".orange
    puts
  end
end
