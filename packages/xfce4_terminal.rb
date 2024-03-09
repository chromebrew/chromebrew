require 'package'

class Xfce4_terminal < Package
  description 'Modern terminal emulator primarily for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  version '0.8.10'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://archive.xfce.org/src/apps/xfce4-terminal/0.8/xfce4-terminal-#{version}.tar.bz2"
  source_sha256 '7a3337c198e01262a0412384823185753ac8a0345be1d6776a7e9bbbcbf33dc7'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'b11aa2b481bf89d83e2d1e8086f8a38947c6f1b1e5ec7b3db2e4a9a71b192aa1',
     armv7l: 'b11aa2b481bf89d83e2d1e8086f8a38947c6f1b1e5ec7b3db2e4a9a71b192aa1',
     x86_64: 'dfa50e1a41870d5e63316a95fccd57a51e420045c8fd583a9bcc18ead9ddaa71'
  })

  depends_on 'desktop_file_utilities'
  depends_on 'vte'
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
