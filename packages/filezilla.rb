require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.65.0-1'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.65.0_src.tar.xz'
  source_sha256 'd2bce4dbaa80fe035836db19441e90befcbabdef5556e9a4b3d4dd233638bdea'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.65.0-1_armv7l/filezilla-3.65.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.65.0-1_armv7l/filezilla-3.65.0-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.65.0-1_x86_64/filezilla-3.65.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '352fdaf2d1c2d6fd7f3487dd3650a75b6695a046b8cf14b5d5fe15f54c01b14f',
     armv7l: '352fdaf2d1c2d6fd7f3487dd3650a75b6695a046b8cf14b5d5fe15f54c01b14f',
     x86_64: '5f5276b73062447835af8cdc05a2e36c7f570ef3256f648389590034b796533a'
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
  depends_on 'zlibpkg' # R

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --with-pugixml=builtin"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    File.write 'filezilla', <<~FILEZILLA_EOF
      alias filezilla="WAYLAND_DISPLAY=wayland-0 DISPLAY='' GDK_BACKEND=wayland filezilla"
    FILEZILLA_EOF
    FileUtils.install 'filezilla', "#{CREW_DEST_PREFIX}/etc/env.d/10-filezilla", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nTo finish the installation, please execute the following:\nsource ~/.bashrc".lightblue, print_last: true
  end
end
