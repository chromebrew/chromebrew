require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  @_ver = '3.55.0'
  version @_ver
  license 'GPL-2'
  compatibility 'aarch64,armv7l,x86_64'
  source_url "https://download.filezilla-project.org/client/FileZilla_#{@_ver}_src.tar.bz2"
  source_sha256 'ae70eb4180d136be29bbad6fcdd188e497e205fc416ea3e413dce7cd8cab9c82'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.55.0_armv7l/filezilla-3.55.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.55.0_armv7l/filezilla-3.55.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.55.0_x86_64/filezilla-3.55.0-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    aarch64: '7135323bf1f3bdb82f37610867c7ca8e8b6a22990cd464ccf021952cc73816b7',
     armv7l: '7135323bf1f3bdb82f37610867c7ca8e8b6a22990cd464ccf021952cc73816b7',
     x86_64: 'f0effe1033d2d3a5ab548077c0d3a71e24877f132520c08381bd5e23c9cf45f1',
  })

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
  depends_on 'wxwidgets'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS} --disable-maintainer-mode --with-pugixml=builtin"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'alias filezilla=\"WAYLAND_DISPLAY=wayland-0 DISPLAY=\'\' GDK_BACKEND=wayland filezilla\"' >> ~/.bashrc".lightblue
  end
end
