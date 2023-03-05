require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.63.2.1'
  license 'GPL-2'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.63.2.1_src.tar.bz2'
  source_sha256 '6dc14c6f7f4de7e44c8429b32f7f9edbbf10732d21dd75d8974ae44007b7b79d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.63.2.1_armv7l/filezilla-3.63.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.63.2.1_armv7l/filezilla-3.63.2.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/filezilla/3.63.2.1_x86_64/filezilla-3.63.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0f2797a486f08daf0beea70493e3cb66466d7a908c9531002269cb754ad6f287',
     armv7l: '0f2797a486f08daf0beea70493e3cb66466d7a908c9531002269cb754ad6f287',
     x86_64: 'fc5cf25b9cfdae4b0c82ff0ab9fd7c4de90e9f7303e9f091b5d6ec35513d6504'
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
