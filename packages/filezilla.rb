require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.48.1'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.48.1_src.tar.bz2'
  source_sha256 'abffd877ff9006e8e50ce4957393f0a27cc0a7360e626123ef15974eee13ef5d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'dbus'
  depends_on 'gnome_icon_theme'
  depends_on 'hicolor_icon_theme'
  depends_on 'libfilezilla'
  depends_on 'libidn2'
  depends_on 'sqlite'
  depends_on 'wxwidgets'
  depends_on 'xdg_utils'
  depends_on 'sommelier'

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --with-pugixml=builtin"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
