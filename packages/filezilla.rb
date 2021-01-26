require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  @_ver = '3.52.2'
  version @_ver
  compatibility 'all'
  source_url "https://download.filezilla-project.org/client/FileZilla_#{@_ver}_src.tar.bz2"
  source_sha256 'c0788816928a26e8863c7dc26b158644e71bef29406df7d2eda37dc4810d6cdf'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.52.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.52.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.52.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.52.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '3585d8326e1784c9d690539a76854fe50c5aa81a7996bc4f97bf11a00dcb959e',
      armv7l: '3585d8326e1784c9d690539a76854fe50c5aa81a7996bc4f97bf11a00dcb959e',
        i686: 'a6bf0b25146e61c126f52d8a9b5efdea4fc25d03261b80a347fadff4af95f657',
      x86_64: '336b624e5ae3e75a4b6bd2d008c3220347bc5bfba2cf8a1187090bc9ac450e4f',
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
