require 'package'

class Broadway < Package
  description 'Run GTK applications in a browser window.'
  homepage 'https://developer.gnome.org/gtk3/stable/gtk-broadway.html'
  version 'gtk3.22-3'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk3'

  def self.build
    system "echo 'GDK_BACKEND=broadway' > .broadway.env"
    system "echo 'XDG_RUNTIME_DIR=/var/run/chrome' >> .broadway.env"
    system "echo 'BROADWAY_DISPLAY=:5' >> .broadway.env"
    system "echo '#!/bin/bash' > initbroadway"
    system "echo 'BROADWAYD=\$(pidof broadwayd 2>/dev/null)' >> initbroadway"
    system "echo 'if [ -z \"\${BROADWAYD}\" ]; then' >> initbroadway"
    system "echo '  [ -f #{CREW_PREFIX}/bin/stopsommelier ] && stopsommelier' >> initbroadway"
    system "echo '  broadwayd \${BROADWAY_DISPLAY} &' >> initbroadway"
    system "echo '  sleep 3' >> initbroadway"
    system "echo 'fi' >> initbroadway"
    system "echo 'BROADWAYD=\$(pidof broadwayd 2>/dev/null)' >> initbroadway"
    system "echo 'if [ ! -z \"\${BROADWAYD}\" ]; then' >> initbroadway"
    system "echo '  echo \"broadwayd process \${BROADWAYD} is running\"' >> initbroadway"
    system "echo 'else' >> initbroadway"
    system "echo '  echo \"broadwayd failed to start\"' >> initbroadway"
    system "echo '  exit 1' >> initbroadway"
    system "echo 'fi' >> initbroadway"
    system "echo '#!/bin/bash' > stopbroadway"
    system "echo >> stopbroadway"
    system "echo 'BROADWAYD=\$(pidof broadwayd 2>/dev/null)' >> stopbroadway"
    system "echo 'if [ ! -z \"\${BROADWAYD}\" ]; then' >> stopbroadway"
    system "echo '  pkill broadwayd' >> stopbroadway"
    system "echo '  sleep 3' >> stopbroadway"
    system "echo 'fi' >> stopbroadway"
    system "echo 'BROADWAYD=\$(pidof broadwayd 2> /dev/null)' >> stopbroadway"
    system "echo 'if [ -z \"\${BROADWAYD}\" ]; then' >> stopbroadway"
    system "echo '  echo \"broadwayd process stopped\"' >> stopbroadway"
    system "echo 'else' >> stopbroadway"
    system "echo '  echo \"broadwayd process \${BROADWAYD} is running\"' >> stopbroadway"
    system "echo '  exit 1' >> stopbroadway"
    system "echo 'fi' >> stopbroadway"
  end

  def self.install
    system "install -Dm755 initbroadway #{CREW_DEST_PREFIX}/bin/initbroadway"
    system "install -Dm755 stopbroadway #{CREW_DEST_PREFIX}/bin/stopbroadway"
    system "install -Dm644 .broadway.env #{CREW_DEST_HOME}/.broadway.env"
  end

  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo '# Broadway environment variables + daemon' >> ~/.bashrc".lightblue
    puts "echo '# See https://developer.gnome.org/gtk3/stable/gtk-broadway.html' >> ~/.bashrc".lightblue
    puts "echo 'alias startbroadway=\"set -a && source ~/.broadway.env && set +a && initbroadway\"' >> ~/.bashrc".lightblue
    puts "echo 'startbroadway' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To start the broadwayd daemon, run 'startbroadway'".lightblue
    puts "To stop the broadwayd daemon, run 'stopbroadway'".lightblue
    puts
    puts "To adjust environment variables, edit ~/.broadway.env".lightblue
    puts
    puts "Navigate your browser to http://127.0.0.1:8085 while the broadwayd".lightblue
    puts "daemon is running to run GTK applications in the browser window.".lightblue
    puts
    puts "Please be aware that gtk applications may not work without the broadwayd daemon running.".orange
    puts
  end
end
