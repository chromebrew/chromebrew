require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.67.1'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  # NOTE: This may generate a 403 forbidden error. To receive a new source url,
  # download from here: https://filezilla-project.org/download.php?show_all=1.
  source_url "https://dl4.cdn.filezilla-project.org/client/FileZilla_#{version}_src.tar.xz?h=lc3XtUiYRgT_RWF74oRGPA&x=1726381543"
  source_sha256 '10468e6ef623ad9789996df61f588ca7417d39353678313611d54f2d8131a1db'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a727d04dac75bab9bb8aeaaa1cc7b224dcba459d0c35a26dff9e6c66a7e73074',
     armv7l: 'a727d04dac75bab9bb8aeaaa1cc7b224dcba459d0c35a26dff9e6c66a7e73074',
     x86_64: '8917e28eabda3cee162aa13095095884536402bef4370e774f056e45d5a0b6e4'
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

  print_source_bashrc

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_CONFIGURE_OPTIONS} --disable-maintainer-mode --with-pugixml=builtin"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    File.write 'filezilla', <<~FILEZILLA_EOF
      alias filezilla="WAYLAND_DISPLAY=wayland-0 DISPLAY='' GDK_BACKEND=wayland filezilla"
    FILEZILLA_EOF
    FileUtils.install 'filezilla', "#{CREW_DEST_PREFIX}/etc/env.d/10-filezilla", mode: 0o644
  end
end
