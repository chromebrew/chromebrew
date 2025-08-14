require 'buildsystems/autotools'

class Xfce4_terminal < Autotools
  description 'Modern terminal emulator primarily for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  version '1.1.5'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.xfce.org/apps/xfce4-terminal.git'
  git_hashtag "xfce-terminal-#{version}"
  binary_compression 'tar.zst'

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

  autotools_install_extras do
    system "cat <<'EOF'> xfce4-terminal
#!/bin/bash
WAYLAND_DISPLAY=wayland-0
GDK_BACKEND=wayland
DISPLAY=
#{CREW_PREFIX}/bin/xfce4_terminal \"$@\"
EOF"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/xfce4-terminal", "#{CREW_DEST_PREFIX}/bin/xfce4_terminal"
    FileUtils.install 'xfce4-terminal', "#{CREW_DEST_PREFIX}/bin/xfce4-terminal", mode: 0o755
  end
end
