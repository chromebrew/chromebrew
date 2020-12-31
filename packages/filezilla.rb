require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.51.0-1'
  compatibility 'all'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.51.0_src.tar.bz2'
  source_sha256 '82be1c4a4f51bb32a599d0b4cc3a24127ba948c0af0f957233cc6a13ea3b6c4c'

  depends_on 'dbus'
  depends_on 'gnome_icon_theme'
  depends_on 'hicolor_icon_theme'
  depends_on 'libfilezilla'
  depends_on 'libidn2'
  depends_on 'sqlite'
  depends_on 'wxwidgets'
  depends_on 'xdg_utils'
  depends_on 'libwebp'
  depends_on 'wayland_protocols'
  depends_on 'mesa'
  depends_on 'xcb_util'
  

  def self.patch
    system 'filefix'
  end

  def self.build
    ENV['CC'] = 'gcc'
    ENV['CXX'] = 'g++'
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --with-pugixml=builtin"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mv '#{CREW_DEST_PREFIX}/bin/filezilla', '#{CREW_DEST_PREFIX}/bin/filezilla_orig'
    system "cat <<'EOF'> filezilla
WAYLAND_DISPLAY=wayland-0
GDK_BACKEND=wayland
DISPLAY=
#{CREW_PREFIX}/bin/filezilla_orig $@
EOF"
    system "install -Dm755 filezilla #{CREW_DEST_PREFIX}/bin/filezilla"
  end
end
