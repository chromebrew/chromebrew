require 'package'

class Openbox < Package
  description 'Openbox is a highly configurable, next generation window manager with extensive standards support.'
  homepage 'http://openbox.org/'
  version '3.6.1'
  compatibility 'all'
  source_url 'http://openbox.org/dist/openbox/openbox-3.6.1.tar.xz'
  source_sha256 'abe75855cc5616554ffd47134ad15291fe37ebbebf1a80b69cbde9d670f0e26d'

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
  depends_on 'adwaita_icon_theme'
  depends_on 'xdpyinfo'
  depends_on 'sommelier'

  ENV['CFLAGS'] = "-lX11 -lXau"
  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "cat <<'EOF'> startopenbox
#!/bin/bash
stopsommelier
echo am start x.org.server/.MainActivity | sudo android-sh
echo Starting XServer XSDL
# Wait for XSDL X server
MAX_ATTEMPTS=120 # About 60 seconds
COUNT=0
echo -n \"Waiting for X server to be ready...\"
while ! xdpyinfo -display ${DISPLAY} >/dev/null 2>&1; do
  echo -n \".\"
  sleep 0.50s
  COUNT=$(( COUNT + 1 ))
  if [ \"${COUNT}\" -ge \"${MAX_ATTEMPTS}\" ]; then
    echo \"  Gave up waiting for X server on ${DISPLAY}\"
    exit 1
  fi
done
echo \"  Done - X server is ready!\"
EOF"
    system "echo 'export DISPLAY=100.115.92.2:0' >> startopenbox"
    system "echo 'openbox \"$@\" &' >> startopenbox"
    system "echo 'echo XServer closed or logged out session' >> startopenbox"
    system "echo 'startsommelier' >> startopenbox"
    system "echo 'export DISPLAY=:0' >> startopenbox"
    # For Chrome OS/Chromium OS/Cloudready without android arc container support
    # Use 'xinit'
    system "install -Dm755 startopenbox #{CREW_DEST_PREFIX}/bin/startopenbox"
    puts "Your cpu architecture is `uname -m`".lightgreen
  end

  def self.check
    system "make", "check"
  end
  def self.postinstall
      system "echo '#!/bin/bash' > cloudready.sh"
      system "temp=\"echo 'pkill twm && openbox &' >> /usr/local/etc/X11/xinit/xinitrc\" && echo \"if [[ '$(cat /etc/lsb-release | grep CHROMEOS_ARC_ANDROID_SDK_VERSION)' = '' ]]; then crew install xinit && $temp ; fi\" >> cloudready.sh"
      system "bash cloudready.sh && rm cloudready.sh"
      puts
      puts "For Chrome OS/Fyde OS user:".lightblue
      puts "To use this package, you need to download XServer XSDL from Google Play Store".lightblue
      puts "Use 'startopenbox' instead of 'openbox' to execute this package".lightblue
      puts "For Cloudready/Chromium OS user:".lightblue
      puts "Use 'xinit' instead of 'openbox' to execute this package".lightblue
      puts "For legacy processor user, set up XServer XSDL on phone".lightblue
  end
end
