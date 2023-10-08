require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.65.0'
  license 'GPL-2'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.65.0_src.tar.xz'
  source_sha256 'd2bce4dbaa80fe035836db19441e90befcbabdef5556e9a4b3d4dd233638bdea'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.65.0_armv7l/filezilla-3.65.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.65.0_armv7l/filezilla-3.65.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.65.0_x86_64/filezilla-3.65.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f49b082757566af7af6e8ba163646e92c3e34eaf24805ee1714734781888f820',
     armv7l: 'f49b082757566af7af6e8ba163646e92c3e34eaf24805ee1714734781888f820',
     x86_64: '410919de0ec45804e14177d0f79f754d469b66b95e62ac87e787852cb7b4d123'
  })

  depends_on 'boost'
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

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --with-pugixml=builtin"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    File.write 'filezilla', <<~EOF
      alias filezilla="WAYLAND_DISPLAY=wayland-0 DISPLAY='' GDK_BACKEND=wayland filezilla"
    EOF
    FileUtils.install 'filezilla', "#{CREW_DEST_PREFIX}/etc/env.d/10-filezilla", mode: 0o644
  end

  def self.postinstall
    puts "\nTo complete the installation, execute the following:".lightblue
    puts "source ~/.bashrc\n".lightblue
  end
end
