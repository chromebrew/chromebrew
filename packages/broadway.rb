require 'package'

class Broadway < Package
  description 'Run GTK applications in a browser window.'
  homepage 'https://developer.gnome.org/gtk3/stable/gtk-broadway.html'
  version 'gtk3.22-3'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
  })
  binary_sha256({
  })

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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    @broadway = <<~BROADWAYEOF
      alias startbroadway="set -a && source #{CREW_DEST_HOME}/.broadway.env && set +a && initbroadway"
    BROADWAYEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/broadway", @broadway)
  end

  def self.install
    system "install -Dm755 initbroadway #{CREW_DEST_PREFIX}/bin/initbroadway"
    system "install -Dm755 stopbroadway #{CREW_DEST_PREFIX}/bin/stopbroadway"
  end

  def self.postinstall
    puts
    puts 'To complete the installation, execute the following:'.lightblue
    puts "echo '# Broadway environment variables + daemon' >> #{CREW_PREFIX}/etc/env.d/profile".lightblue
    puts "echo '# See https://developer.gnome.org/gtk3/stable/gtk-broadway.html' >> #{CREW_PREFIX}/etc/env.d/profile".lightblue
    puts "To start the broadwayd daemon, run 'startbroadway'".lightblue
    puts "To stop the broadwayd daemon, run 'stopbroadway'".lightblue
    puts
    puts "To adjust environment variables, edit #{CREW_DEST_HOME}/.broadway.env".lightblue
    puts
    puts 'Navigate your browser to http://127.0.0.1:8085 while the broadwayd'.lightblue
    puts 'daemon is running to run GTK applications in the browser window.'.lightblue
    puts
    puts 'Please be aware that gtk applications may not work without the broadwayd daemon running.'.orange
    puts
  end
end
