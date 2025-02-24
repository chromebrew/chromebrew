require 'buildsystems/autotools'

class Filezilla < Autotools
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.68.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  # NOTE: This may generate a 403 forbidden error. To receive a new source url,
  # download from here: https://filezilla-project.org/download.php?show_all=1.
  source_url "https://dl2.cdn.filezilla-project.org/client/FileZilla_3.68.1_src.tar.xz?h=skd4cOQdsN3A5aBPQdOKWg&x=1740339243"
  source_sha256 '10468e6ef623ad9789996df61f588ca7417d39353678313611d54f2d8131a1db'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4a5a3ea8abade4a1331971fd638e4673a815753b4ff909109872ee6b923bfe3',
     armv7l: 'f4a5a3ea8abade4a1331971fd638e4673a815753b4ff909109872ee6b923bfe3',
     x86_64: '009b3c733ca4f8f38beceb7fd018623e109e1f582829a17e4eb99beb830c9ef2'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'boost' => :build
  depends_on 'cairo' # R
  depends_on 'dbus' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnome_icon_theme' # L
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme' # L
  depends_on 'libfilezilla' # L
  depends_on 'libidn2' => :build
  depends_on 'libwebp' => :build
  depends_on 'mesa' => :build
  depends_on 'nettle' # R
  depends_on 'pango' # R
  depends_on 'sqlite' => :build
  depends_on 'sqlite' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'wxwidgets' # R
  depends_on 'xcb_util' => :build
  depends_on 'xdg_utils' => :build
  depends_on 'zlib' # R
  depends_on 'sqlite' # R

  print_source_bashrc

  configure_options '--disable-maintainer-mode --with-pugixml=builtin'

  configure_build_extras do
    File.write '10-filezilla', <<~FILEZILLA_EOF
      alias filezilla="WAYLAND_DISPLAY=wayland-0 DISPLAY='' GDK_BACKEND=wayland filezilla"
    FILEZILLA_EOF
  end

  configure_install_extras do
    FileUtils.install '10-filezilla', "#{CREW_DEST_PREFIX}/etc/env.d/10-filezilla", mode: 0o644
  end
end
