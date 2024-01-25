require 'package'

class Broadway < Package
  description 'Run GTK applications in a browser window.'
  homepage 'https://developer.gnome.org/gtk3/stable/gtk-broadway.html'
  version 'gtk3.22-3'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'

  binary_sha256({})

  depends_on 'gtk3'

  def self.build
    @broadwayenv = <<~BROADWAYENVEOF
      GDK_BACKEND=broadway
      XDG_RUNTIME_DIR=/var/run/chrome
      BROADWAY_DISPLAY=:5
    BROADWAYENVEOF
    File.write("#{CREW_DEST_HOME}/.broadway.env", @broadwayenv)
    @initbroadway = <<~INITBROADWAYEOF
      #!/bin/bash
      BROADWAYD=$(pidof broadwayd 2>/dev/null)
      if [ -z "${BROADWAYD}" ]; then
        [ -f #{CREW_PREFIX}/bin/stopsommelier ] && stopsommelier
        broadwayd ${BROADWAY_DISPLAY} &
        sleep 3' >> initbroadway
      fi
      BROADWAYD=$(pidof broadwayd 2>/dev/null)
      if [ ! -z "${BROADWAYD}" ]; then
        echo "broadwayd process ${BROADWAYD} is running"
      else
        echo "broadwayd failed to start"
        exit 1
      fi
    INITBROADWAYEOF
    File.write('initbroadway', @initbroadway)
    @stopbroadway = <<~STOPBROADWAYEOF
      #!/bin/bash
      BROADWAYD=$(pidof broadwayd 2>/dev/null)
      if [ ! -z "${BROADWAYD}" ]; then
        pkill broadwayd
        sleep 3
      fi
      BROADWAYD=$(pidof broadwayd 2> /dev/null)
      if [ -z "${BROADWAYD}" ]; then
        echo "broadwayd process stopped"
      else
        echo "broadwayd process ${BROADWAYD} is running"
        exit 1
      fi
    STOPBROADWAYEOF
    File.write('stopbroadway', @stopbroadway)
  end

  def self.install
    FileUtils.install 'initbroadway', "#{CREW_DEST_PREFIX}/bin/initbroadway", mode: 0o755
    FileUtils.install 'stopbroadway', "#{CREW_DEST_PREFIX}/bin/stopbroadway", mode: 0o755
    FileUtils.install '.broadway.env', "#{CREW_DEST_HOME}/.broadway.env", mode: 0o644
  end

  def self.postinstall
    puts
    puts 'To complete the installation, execute the following:'.lightblue
    puts "echo '# Broadway environment variables + daemon' >> ~/.bashrc".lightblue
    puts "echo '# See https://developer.gnome.org/gtk3/stable/gtk-broadway.html' >> ~/.bashrc".lightblue
    puts "echo 'alias startbroadway=\"set -a && source ~/.broadway.env && set +a && initbroadway\"' >> ~/.bashrc".lightblue
    puts "echo 'startbroadway' >> ~/.bashrc".lightblue
    puts 'source ~/.bashrc'.lightblue
    puts
    puts "To start the broadwayd daemon, run 'startbroadway'".lightblue
    puts "To stop the broadwayd daemon, run 'stopbroadway'".lightblue
    puts
    puts "To adjust environment variables, edit #{CREW_HOME}/.broadway.env".lightblue
    puts
    puts 'Navigate your browser to http://127.0.0.1:8085 while the broadwayd'.lightblue
    puts 'daemon is running to run GTK applications in the browser window.'.lightblue
    puts
    puts 'Please be aware that gtk applications may not work without the broadwayd daemon running.'.orange
    puts
  end
end
