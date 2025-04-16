require 'buildsystems/autotools'

class Filezilla < Autotools
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.69.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  # NOTE: This may generate a 403 forbidden error. To receive a new source url,
  # download from here: https://filezilla-project.org/download.php?show_all=1.
  source_url 'https://dl2.cdn.filezilla-project.org/client/FileZilla_3.69.0_src.tar.xz?h=891QO2mtPR32shccVOpwcg&x=1744782753'
  source_sha256 '10468e6ef623ad9789996df61f588ca7417d39353678313611d54f2d8131a1db'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f710527da92002fbd7be4a398cd7e1360cc1260cf5ba3944368559c81edc0e5',
     armv7l: '5f710527da92002fbd7be4a398cd7e1360cc1260cf5ba3944368559c81edc0e5',
     x86_64: 'dc6dbba44b07fd6f3c4e49fe8c4864f7d0d77af83b3c8287d525967ac8014a6f'
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
  depends_on 'sqlite' # R
  depends_on 'wayland_protocols' => :build
  depends_on 'wxwidgets' # R
  depends_on 'xcb_util' => :build
  depends_on 'xdg_utils' => :build
  depends_on 'zlib' # R

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
