require 'buildsystems/meson'

class Xfce4_terminal < Meson
  description 'Modern terminal emulator primarily for the Xfce desktop environment'
  homepage 'https://docs.xfce.org/apps/xfce4-terminal/start'
  version '1.2.0'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.xfce.org/apps/xfce4-terminal.git'
  git_hashtag "xfce4-terminal-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc70564ae81db6a59d1ee0a37e38ee663387228d63a7b5d776c9e151a23be161',
     armv7l: 'cc70564ae81db6a59d1ee0a37e38ee663387228d63a7b5d776c9e151a23be161',
     x86_64: '7fc14ba1b67f7644474614c4476e62e4c36aaa90e5aaac12b4263ead39f8255d'
  })

  depends_on 'at_spi2_core' => :executable
  depends_on 'cairo' => :executable
  depends_on 'desktop_file_utilities' => :executable
  depends_on 'exo' => :build
  depends_on 'gdk_pixbuf' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gtk3' => :executable
  depends_on 'gtk_layer_shell' => :executable
  depends_on 'hicolor_icon_theme' => :executable
  depends_on 'libutempter' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxfce4ui' => :executable
  depends_on 'libxfce4util' => :executable
  depends_on 'libxslt' => :executable
  depends_on 'mesa' => :executable
  depends_on 'pango' => :executable
  depends_on 'pcre2' => :executable
  depends_on 'startup_notification' => :executable
  depends_on 'vte' => :executable
  depends_on 'wayland_protocols' => :executable
  depends_on 'xfconf' => :executable

  meson_build_extras do
    File.write 'xfce4-terminal', <<~EOF
      #!/bin/bash
      WAYLAND_DISPLAY=wayland-0
      GDK_BACKEND=wayland
      DISPLAY=
      #{CREW_PREFIX}/bin/xfce4_terminal "$@"
    EOF
  end

  meson_install_extras do
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/xfce4-terminal", "#{CREW_DEST_PREFIX}/bin/xfce4_terminal"
    FileUtils.install 'xfce4-terminal', "#{CREW_DEST_PREFIX}/bin/xfce4-terminal", mode: 0o755
  end
end
