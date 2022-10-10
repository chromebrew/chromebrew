require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  @_ver = '3.61.0'
  version @_ver
  license 'GPL-2'
  compatibility 'aarch64,armv7l,x86_64'
  source_url "https://download.filezilla-project.org/client/FileZilla_#{@_ver}_src.tar.bz2"
  source_sha256 '0afef0e4da25202687b32ed6b1ffcd8442d5b35bdcd16df4f02bb2ea92e299f7'

  binary_url({
  })
  binary_sha256({
  })

  depends_on 'dbus'
  depends_on 'gnome_icon_theme'
  depends_on 'hicolor_icon_theme'
  depends_on 'libfilezilla'
  depends_on 'libidn2'
  depends_on 'sqlite'
  depends_on 'wxwidgets30'
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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    filezilla = <<~'EOF'
      alias filezilla="WAYLAND_DISPLAY=wayland-0 DISPLAY='' GDK_BACKEND=wayland filezilla"
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-filezilla", filezilla)
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts "\nTo complete the installation, execute the following:".lightblue
    puts "source ~/.bashrc\n".lightblue
  end
end
