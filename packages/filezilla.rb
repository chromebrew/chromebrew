require 'package'

class Filezilla < Package
  description 'FileZilla Client is a free FTP solution.'
  homepage 'https://filezilla-project.org/'
  version '3.48.1'
  source_url 'https://download.filezilla-project.org/client/FileZilla_3.48.1_src.tar.bz2'
  source_sha256 'abffd877ff9006e8e50ce4957393f0a27cc0a7360e626123ef15974eee13ef5d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.48.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.48.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.48.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filezilla-3.48.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c513db2c717525df2ef6736ef4c4f04244fbb4a972b0ac3f4cd68b315a26799b',
     armv7l: 'c513db2c717525df2ef6736ef4c4f04244fbb4a972b0ac3f4cd68b315a26799b',
       i686: '29d47a963482a86e3aa8a1b93e0cb333fa1760e885b7c6d074916bf8a694d9c3',
     x86_64: '7dbc80bf57b891a2165eb601b0abe2f5079129f8171c17622e4ce2dcd1aa18e8',
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
