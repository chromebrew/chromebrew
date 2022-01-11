require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  @_ver = '3.57.0'
  version @_ver
  license 'GPL-2'
  compatibility 'aarch64,armv7l,x86_64'
  source_url "https://download.filezilla-project.org/client/FileZilla_#{@_ver}_src.tar.bz2"
  source_sha256 '82bf6c7077ca13012549356b463952f124ee04876f21e4ba720acc9811c899c7'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.57.0_armv7l/filezilla-3.57.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.57.0_armv7l/filezilla-3.57.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.57.0_x86_64/filezilla-3.57.0-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    aarch64: '9424564c24eb816a71355aba791b9e89292392b6978e53900a1ba28c3883b385',
     armv7l: '9424564c24eb816a71355aba791b9e89292392b6978e53900a1ba28c3883b385',
     x86_64: '1df2e247ff0260b949dd182ff6151ac4a6e7db16b898bbb904303a79eda87c66',
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
