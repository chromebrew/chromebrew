require 'package'

class Broadway < Package
  description 'Run GTK applications in a browser window.'
  homepage 'http://127.0.0.1:8085'
  version 'gtk3.22'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk3'

  def self.build
    system "echo '#!/bin/bash' > startbroadwayd"
    system "echo >> startbroadwayd"
    system "echo '  BROADWAYD=\$(pidof broadwayd 2>/dev/null)' >> startbroadwayd"
    system "echo '  if [ -z \"\${BROADWAYD}\" ]; then' >> startbroadwayd"
    system "echo '    broadwayd \${BROADWAY_DISPLAY} &>/dev/null &' >> startbroadwayd"
    system "echo '    sleep 3' >> startbroadwayd"
    system "echo '  fi' >> startbroadwayd"
    system "echo '  BROADWAYD=\$(pidof broadwayd 2>/dev/null)' >> startbroadwayd"
    system "echo '  if [ ! -z \"\${BROADWAYD}\" ]; then' >> startbroadwayd"
    system "echo '    echo \"broadwayd process \${BROADWAYD} is running\"' >> startbroadwayd"
    system "echo '  else' >> startbroadwayd"
    system "echo '    echo \"broadwayd failed to start\"' >> startbroadwayd"
    system "echo '    exit 1' >> startbroadwayd"
    system "echo '  fi' >> startbroadwayd"
    system "echo '#!/bin/bash' > stopbroadwayd"
    system "echo >> stopbroadwayd"
    system "echo '  BROADWAYD=\$(pidof broadwayd 2>/dev/null)' >> stopbroadwayd"
    system "echo '  if [ ! -z \"\${BROADWAYD}\" ]; then' >> stopbroadwayd"
    system "echo '    pkill broadwayd' >> stopbroadwayd"
    system "echo '    sleep 3' >> stopbroadwayd"
    system "echo '  fi' >> stopbroadwayd"
    system "echo '  BROADWAYD=\$(pidof broadwayd 2> /dev/null)' >> stopbroadwayd"
    system "echo '  if [ -z \"\${BROADWAYD}\" ]; then' >> stopbroadwayd"
    system "echo '    echo \"broadwayd process stopped\"' >> stopbroadwayd"
    system "echo '  else' >> stopbroadwayd"
    system "echo '    echo \"broadwayd process \${BROADWAYD} is running\"' >> stopbroadwayd"
    system "echo '    exit 1' >> stopbroadwayd"
    system "echo '  fi' >> stopbroadwayd"
  end

  def self.install
    system "install -Dm755 startbroadwayd #{CREW_DEST_PREFIX}/bin/startbroadwayd"
    system "install -Dm755 stopbroadwayd #{CREW_DEST_PREFIX}/bin/stopbroadwayd"
  end

  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo '# Broadway environment variables + daemon' >> ~/.bashrc".lightblue
    puts "echo 'if [[ -z \"\${GDK_BACKEND}\" ]]; then' >> ~/.bashrc".lightblue
    puts "echo '  export GDK_BACKEND=broadway' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "echo 'if [[ -z \"\${XDG_RUNTIME_DIR}\" ]]; then' >> ~/.bashrc".lightblue
    puts "echo '  export XDG_RUNTIME_DIR=/var/run/chrome' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "echo 'export BROADWAY_DISPLAY=:5' >> ~/.bashrc".lightblue
    puts "echo 'startbroadwayd' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To stop the broadwayd daemon, run 'stopbroadwayd'".lightblue
    puts
    puts "Please be aware that gtk applications may not work without the broadwayd daemon running.".orange
    puts "Broadway may also not work if Sommelier is installed; If you have any issues, run these commands:".orange
    puts
    puts "sed -i 's,^export GDK_BACKEND=wayland,#&,g' ~/.bashrc".orange
    puts "unset GDK_BACKEND && source ~/.bashrc".orange
    puts
    puts "Navigate your browser to http://127.0.0.1:8085 while the broadwayd".lightblue
    puts "daemon is running to run GTK applications in the browser window.".lightblue
    puts
  end
end
