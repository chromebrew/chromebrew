require 'package'

class Openbox < Package
  description 'Openbox is a highly configurable, next generation window manager with extensive standards support.'
  homepage 'http://openbox.org/'
  version '3.6.1'
  compatibility 'all'
  source_url 'http://openbox.org/dist/openbox/openbox-3.6.1.tar.xz'
  source_sha256 'abe75855cc5616554ffd47134ad15291fe37ebbebf1a80b69cbde9d670f0e26d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openbox-3.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openbox-3.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openbox-3.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openbox-3.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0bf8f99523d3194bd04c4ae49dc6b1f01b93852d141117aae56a0c7a8f946201',
     armv7l: '0bf8f99523d3194bd04c4ae49dc6b1f01b93852d141117aae56a0c7a8f946201',
       i686: 'e58f0787ecef84e8f87389c9aca8b5a35e0846a0a6b8223c01cf4ea447ac6ac6',
     x86_64: 'f6f6b3a0fcab357ce8f7dce834e119dd87ad7770412e83890c141dfb7979e59e',
  })

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
  depends_on 'pango'
  depends_on 'pangomm'
  depends_on 'graphite'
  depends_on 'harfbuzz'
  depends_on 'libx11' => :build
  depends_on 'adwaita_icon_theme'
  depends_on 'xdpyinfo'
  depends_on 'gtk2'
  depends_on 'gtk3'
  depends_on 'xorg_server'

  ENV['CFLAGS'] = "-lX11 -lXau"
  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "cat <<'EOF'> startopenbox
#!/bin/bash
stopsommelier
echo am start x.org.server/.MainActivity | sudo android-sh
echo Starting XServer XSDL
# Wait for XSDL X server
MAX_ATTEMPTS=120 # About 60 seconds
COUNT=0
echo -n \"Waiting for X server to be ready...\"
while ! xdpyinfo -display \${DISPLAY} >/dev/null 2>&1; do
  echo -n \".\"
  sleep 0.50s
  COUNT=\$(( COUNT + 1 ))
  if [ \"\${COUNT}\" -ge \"\${MAX_ATTEMPTS}\" ]; then
    echo \"  Gave up waiting for X server on \${DISPLAY}\"
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
    puts "Your cpu architecture is #{ARCH}".lightgreen
  end

  def self.check
    #system 'make', 'check'
  end

  def self.postinstall
    system "echo '#!/bin/bash' > cloudready.sh"
    system "temp=\"echo 'pkill twm && openbox &' >> #{CREW_PREFIX}/etc/X11/xinit/xinitrc\" && echo \"if [[ '$(cat /etc/lsb-release | grep CHROMEOS_ARC_ANDROID_SDK_VERSION)' = '' ]]; then crew install xinit && \$temp ; fi\" >> cloudready.sh"
    system "bash cloudready.sh"
    puts
    puts "For Chrome OS/Fyde OS user:".lightblue
    puts "To use this package, you need to download XServer XSDL from Google Play Store".lightblue
    puts "Use 'startopenbox' instead of 'openbox' to execute this package".lightblue
    puts
    puts "For Cloudready/Chromium OS user:".lightblue
    puts "Use 'xinit' instead of 'openbox' to execute this package".lightblue
    puts "For legacy processor user, set up XServer XSDL on phone".lightblue
    puts
  end
end
