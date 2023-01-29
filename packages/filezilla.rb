require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.63.1'
  license 'GPL-2'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.63.1_src.tar.bz2'
  source_sha256 '4e0b5c0f79f4f8bca4ba21e713ba97b86d5b45c4723de67b9c10d23bf417a37f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.63.1_armv7l/filezilla-3.63.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.63.1_armv7l/filezilla-3.63.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.63.1_x86_64/filezilla-3.63.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3e0dd61dd48adb2a4a1a3412f77b0dafdfa3ac7d6a3949ec037c43aa59e89eb2',
     armv7l: '3e0dd61dd48adb2a4a1a3412f77b0dafdfa3ac7d6a3949ec037c43aa59e89eb2',
     x86_64: 'e07cbcb631ea7b6d77f27aee52a4d060c2015e48364d6c5903cd501c4d0edcb5'
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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    filezilla = <<~'EOF'
      alias filezilla="WAYLAND_DISPLAY=wayland-0 DISPLAY='' GDK_BACKEND=wayland filezilla"
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-filezilla", filezilla)
  end

  def self.postinstall
    puts "\nTo complete the installation, execute the following:".lightblue
    puts "source ~/.bashrc\n".lightblue
  end
end
