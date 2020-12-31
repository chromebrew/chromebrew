require 'package'

class Xfce4_terminal < Package
  description 'Modern terminal emulator primarly for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  version '0.8.10'
  compatibility 'all'
  source_url "https://archive.xfce.org/src/apps/xfce4-terminal/0.8/xfce4-terminal-#{version}.tar.bz2"
  source_sha256 '7a3337c198e01262a0412384823185753ac8a0345be1d6776a7e9bbbcbf33dc7'

  depends_on 'desktop_file_utilities'
  depends_on 'gtkvte'
  depends_on 'exo' => :build
  depends_on 'hicolor_icon_theme'
  depends_on 'libxfce4ui'
  depends_on 'startup_notification'
  depends_on 'wayland_protocols'
  depends_on 'mesa'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
    system "cat <<'EOF'> xfce4-terminal
#!/bin/bash
WAYLAND_DISPLAY=wayland-0
GDK_BACKEND=wayland
DISPLAY=
#{CREW_PREFIX}/bin/xfce4_terminal \"$@\"
EOF"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/xfce4-terminal", "#{CREW_DEST_PREFIX}/bin/xfce4_terminal"
    system "install -Dm755 xfce4-terminal #{CREW_DEST_PREFIX}/bin/xfce4-terminal"
  end
end
