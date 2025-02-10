require 'package'
require_relative 'gtk3'

class Broadway < Package
  description 'Run GTK applications in a browser window.'
  homepage 'https://docs.gtk.org/gtk3/broadway.html'
  version Gtk3.version
  license Gtk3.license
  compatibility Gtk3.compatibility
  source_url 'SKIP'

  depends_on 'gtk3'

  no_compile_needed
  no_upstream_update
  print_source_bashrc

  def self.build
    File.write 'broadway.env', <<~BROADWAYENVEOF
      # Broadway environment variables + daemon
      # See https://docs.gtk.org/gtk3/broadway.html.
      GDK_BACKEND=broadway
      XDG_RUNTIME_DIR=/var/run/chrome
      BROADWAY_DISPLAY=:5
    BROADWAYENVEOF
    File.write '10-broadway', <<~BROADWAYEOF
      #!/bin/bash
      startbroadway
    BROADWAYEOF
    File.write 'startbroadway', <<~STARTBROADWAYEOF
      #!/bin/bash
      BROADWAYD=$(pidof broadwayd 2>/dev/null)
      if [ -z "${BROADWAYD}" ]; then
        [ -f #{CREW_PREFIX}/bin/stopsommelier ] && stopsommelier
        broadwayd ${BROADWAY_DISPLAY} &
        sleep 3
      fi
      BROADWAYD=$(pidof broadwayd 2>/dev/null)
      if [ ! -z "${BROADWAYD}" ]; then
        echo "broadwayd process ${BROADWAYD} is running"
      else
        echo "broadwayd failed to start"
        exit 1
      fi
    STARTBROADWAYEOF
    File.write 'stopbroadway', <<~STOPBROADWAYEOF
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
  end

  def self.install
    FileUtils.install 'startbroadway', "#{CREW_DEST_PREFIX}/bin/startbroadway", mode: 0o755
    FileUtils.install 'stopbroadway', "#{CREW_DEST_PREFIX}/bin/stopbroadway", mode: 0o755
    FileUtils.install '10-broadway', "#{CREW_DEST_PREFIX}/etc/bash.d/10-broadway", mode: 0o755
    FileUtils.install 'broadway.env', "#{CREW_DEST_PREFIX}/etc/env.d/broadway.env", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      Run 'startbroadway' to start the broadwayd daemon.
      Run 'stopbroadway' to stop the broadwayd daemon.

      To adjust environment variables, edit #{CREW_PREFIX}/etc/env.d/broadway.env.

      Navigate your browser to http://127.0.0.1:8085 while the broadwayd
      daemon is running to run GTK applications in the browser window.

      Please be aware that gtk applications may not work without the broadwayd daemon running.

    EOM
  end
end
