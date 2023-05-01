require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.64.0'
  license 'GPL-2'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.64.0_src.tar.xz'
  source_sha256 '813d184d54984cf0fb27a455423089070e273b2ef8a70cb613e741170edf479a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.64.0_armv7l/filezilla-3.64.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.64.0_armv7l/filezilla-3.64.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.64.0_x86_64/filezilla-3.64.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '50e6374e6ec43e176f47940c281ec5f6ea089ec44aede3ef1636d6c343d92ad7',
     armv7l: '50e6374e6ec43e176f47940c281ec5f6ea089ec44aede3ef1636d6c343d92ad7',
     x86_64: '56402c6e620466310b85376fd5f6d432ab6aaa93d0a1a335185a588e0e181481'
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
