require 'package'

class Openbox < Package                 # The first character of the class name must be upper case
  description 'Openbox is a highly configurable, next generation window manager with extensive standards support.'
  homepage 'http://openbox.org/'
  version '3.6.1'
  compatibility 'all'
  source_url 'http://openbox.org/dist/openbox/openbox-3.6.1.tar.xz'
  source_sha256 'abe75855cc5616554ffd47134ad15291fe37ebbebf1a80b69cbde9d670f0e26d'   # Use the command "sha256sum"

  depends_on 'libev'
  depends_on 'startup_notification'
  depends_on 'xcb_util_cursor'
  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util_wm'
  depends_on 'xcb_util_xrm'
  depends_on 'yajl'
  depends_on 'wayland' => :build
  depends_on 'xorg_proto'
  depends_on 'glib'
  depends_on 'libxfixes'
  depends_on 'libsm'
  depends_on 'pango' => :build
  depends_on 'libx11' => :build
  # depends_on 'adwaita_icon_theme'
  # depends_on 'xorg_xdpyinfo'
  depends_on 'sommelier'

  ENV['CFLAGS'] = "-lX11 -lXau"
  def self.build                   # the steps required to build the package
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install                 # the steps required to install the package
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "sudo ld /bin/bash /bin/sh"
    # For Chrome OS/Fyde OS with android arc container support
    # Use XServer XSDL
    system "echo '#!/bin/bash' > startopenbox"
    system "echo 'echo Starting XServer XSDL' >> startopenbox"
    system "echo 'echo am start x.org.server/.MainActivity | sudo android-sh' >> startopenbox"
    
    ## Remove the comment if the xorg_xdpyinfo and 'adwaita_icon_theme' package is ready
    # system "cat <EOF>> startopenbox
    ## Wait for XSDL X server
    #MAX_ATTEMPTS=120 # About 60 seconds
    #COUNT=0
    #stopsommelier
    #echo -n \"Waiting for X server to be ready...\"
    #while ! xdpyinfo -display ${DISPLAY} >/dev/null 2>&1; do
    #  echo -n \".\"
    #  sleep 0.50s
    #  export DISPLAY=100.115.92.2:0
    #  COUNT=$(( COUNT + 1 ))
    #  if [ \"${COUNT}\" -ge \"${MAX_ATTEMPTS}\" ]; then
    #    echo \"  Gave up waiting for X server on ${DISPLAY}\"
    #    exit 1
    #  fi
    #done
    #echo \"  Done - X server is ready!\"
    #EOF"
    system "echo 'sleep 7' >> startopenbox"
    system "echo 'export DISPLAY=100.115.92.2:0' >> startopenbox"
    system "echo 'openbox \"$@\"' >> startopenbox"
    system "echo 'startsommelier' >> startopenbox"
    # For Chrome OS/Chromium OS/Cloudready without android arc container support
    # Use 'xinit'
    system "if [[ cat /etc/lsb-release | grep ARC != "" ]]; then echo 'Your OS have Android Support :)'; else if [[ whereis xinit | grep /usr/local/bin/xinit != /usr/local/bin/xinit ]]; then echo 'To use this package, You need to install `xinit` package'; else echo 'pkill twm && openbox &' >> /usr/local/etc/X11/xinit/xinitrc; fi"
    ## For i686 user
    # system "echo 'The unstable method, feel free to test it:)'"
    ## Download ARChon Runtime for Chrome
    # puts "Downloading ARChon Android Runtime for Chrome...".lightblue
    # system "wget http://archon.vf.io/ARChon-v2.1.0-x86_32.zip"
    ## Download XServer Extension for ARChon Runtime
    # puts "Downloading XServer Extension for Chrome...".lightblue
    # system "wget https://github.com/supechicken666/X-Server-Extension-for-Chrome/raw/main/au.com.darkside.XServer.zip"
    # system "echo '#!/bin/bash' > startopenbox_arc-extension"
    # system "cat <EOF>> startopenbox_arc-extension
    ## Wait for X server extension
    # MAX_ATTEMPTS=120 # About 60 seconds
    # COUNT=0
    # echo Please open `au.com.darkside.XServer` extension from app drawer
    # stopsommelier
    # echo -n \"Waiting for X server to be ready...\"
    # while ! xdpyinfo -display ${DISPLAY} >/dev/null 2>&1; do
    #  echo -n \".\"
    #  sleep 0.50s
    #  export DISPLAY=127.0.0.1:0
    #  COUNT=$(( COUNT + 1 ))
    #  if [ \"${COUNT}\" -ge \"${MAX_ATTEMPTS}\" ]; then
    #    echo \"  Gave up waiting for X server on ${DISPLAY}\"
    #    exit 1
    #  fi
    #done
    #echo \"  Done - X server is ready!\"
    #xclock &
    #xterm &
    #openbox &
    #EOF"
    # system "unzip *.zip && mv */ ~/Downloads"
    # puts "Install the two unpack extension to chrome with entension developer mode on".lightblue  
    # system "if [[ $(uname -m) = i686 ]]; then 'install -Dm755 startopenbox_arc-extension #{CREW_DEST_PREFIX}/bin/startopenbox'; else 'install -Dm755 startopenbox #{CREW_DEST_PREFIX}/bin/startopenbox'; fi"
    system "install -Dm755 startopenbox #{CREW_DEST_PREFIX}/bin/startopenbox'"
  end
    
  def self.check                   # the steps required to check if the package was built ok
    system "make", "check"
  end
  def self.postinstall
      puts
      puts "For Chrome OS/Fyde OS user:".lightblue
      puts "To use this package, you need to download XServer XSDL from Google Play Store".lightblue
      puts "Use 'startopenbox' instead of 'openbox' to execute this package".lightblue
      puts "For Cloudready/Chromium OS user:".lightblue
      puts "Use 'xinit' instead of 'openbox' to execute this package".lightblue
      # puts "For legacy processor user, use `startopenbox`".lightblue
      puts "For legacy processor user, set up XServer XSDL on phone".lightblue
  end
end
